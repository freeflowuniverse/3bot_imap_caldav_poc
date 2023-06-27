# POC1: Connecting to IMAP Server via Mail Client

This can be done by running the server in poc1.go
`go run poc1.go -listen localhost:1143 -username <USERNAME> -password <PASSWORD> -insecure-auth true`

For me, using the local address of the IMAP server didn't work, so i used ngrok to expose the IMAP server running on port 1143
`ngrok tcp 1143`

Following that, simply use the following configuration to connect to the IMAP server:
```
Incoming mail server host name: <ngrok_domain>
Username: <username> (defined when running example)
Password: <password> (defined when running example)
```

## Apple Mail (iOS 16.5)

1. Settings -> Mail -> Accounts
2. Add account (other)
3. Add Mail Account
4. Name: Test
5. Email: test@<ngrok_domain>.com
6. Password: test (same as defined in main.go)
7. Host Name: <ngrok_domain> (**write the domain without the tcp schema: i.e 4.tcp.ngrok.io:10107**)
8. Username: <username> (defined when running example)
9. Password: <username> (defined when running example)
10. Outgoing mail server: anything, out of scope of this POC

At first, Apple Mail fails to connect. As such after adding the mail account despite the alert that it might not be able to receive emails as connection wasn't achieved, you can properly configure by clicking advanced options on the newly added mail account.

11. Change IMAP Path Prefix from `/`to `INBOX`
12. Change server port from `143` to the port exposed by ngrok.

For this example TLS isn't necessary. After saving the changes Apple Mail should be able to verify and successfully add the IMAP Server mail account.