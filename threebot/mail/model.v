module mail

import time

pub struct Mail {
	mailboxes []Mailbox
}

struct Mailbox {
	name  string
	mails []Email
}

struct Email {
	time    time.Time
	subject string
	from    EmailAddress
	cc      EmailAddress
	bcc     EmailAddress
	body    string
	flags   []Flag
}

type EmailAddress = string
type Flag = string
