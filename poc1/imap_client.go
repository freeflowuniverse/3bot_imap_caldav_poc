package main

import (
	"log"
	"net"

	"github.com/emersion/go-imap/v2"
	"github.com/emersion/go-imap/v2/imapclient"
)

func main() {

	conn, err := net.Dial("tcp", "localhost:8080")
	if err != nil {
		log.Fatalf("failed to dial IMAP server: %v", err)
	}
	defer conn.Close()

	c := imapclient.New(conn, nil)
	if err != nil {
		log.Fatalf("failed to dial IMAP server: %v", err)
	}
	defer c.Close()

	if err := c.Login("test", "test").Wait(); err != nil {
		log.Fatalf("failed to login: %v", err)
	}

	mailboxes, err := c.List("", "%", nil).Collect()
	if err != nil {
		log.Fatalf("failed to list mailboxes: %v", err)
	}
	log.Printf("Found %v mailboxes", len(mailboxes))
	for _, mbox := range mailboxes {
		log.Printf(" - %v", mbox.Mailbox)
	}

	selectedMbox, err := c.Select("INBOX", nil).Wait()
	if err != nil {
		log.Fatalf("failed to select INBOX: %v", err)
	}
	log.Printf("INBOX contains %v messages", selectedMbox.NumMessages)

	if selectedMbox.NumMessages > 0 {
		seqSet := imap.SeqSetNum(1)
		fetchItems := []imap.FetchItem{imap.FetchItemEnvelope}
		messages, err := c.Fetch(seqSet, fetchItems, nil).Collect()
		if err != nil {
			log.Fatalf("failed to fetch first message in INBOX: %v", err)
		}
		log.Printf("subject of first message in INBOX: %v", messages[0].Envelope.Subject)
	}

	buf := []byte("From: <root@nsa.gov>\r\n\r\nHi <3")
	size := int64(len(buf))
	appendCmd := c.Append("INBOX", size, nil)
	if _, err := appendCmd.Write(buf); err != nil {
		log.Fatalf("failed to write message: %v", err)
	}
	if err := appendCmd.Close(); err != nil {
		log.Fatalf("failed to close message: %v", err)
	}
	if _, err := appendCmd.Wait(); err != nil {
		log.Fatalf("APPEND command failed: %v", err)
	}

	new_mailboxes, err := c.List("", "%", nil).Collect()
	if err != nil {
		log.Fatalf("failed to list mailboxes: %v", err)
	}
	log.Printf("Found %v mailboxes", len(new_mailboxes))
	for _, mbox := range new_mailboxes {
		log.Printf(" - %v", mbox.Mailbox)
	}

	selectedMbox2, err := c.Select("INBOX", nil).Wait()
	if err != nil {
		log.Fatalf("failed to select INBOX: %v", err)
	}
	log.Printf("INBOX contains %v messages", selectedMbox2.NumMessages)

	if selectedMbox2.NumMessages > 0 {
		seqSet := imap.SeqSetNum(1)
		fetchItems := []imap.FetchItem{imap.FetchItemEnvelope}
		messages, err := c.Fetch(seqSet, fetchItems, nil).Collect()
		if err != nil {
			log.Fatalf("failed to fetch first message in INBOX: %v", err)
		}
		log.Printf("subject of first message in INBOX: %v", messages[0].Envelope.Subject)
	}

	if err := c.Logout().Wait(); err != nil {
		log.Fatalf("failed to logout: %v", err)
	}
}