module mail

pub fn (mail Mail) close() ! {}

pub struct LoginParams {
	username string
	password string
}

pub fn (mail Mail) login(params LoginParams) ! {}

pub struct SelectParams {
	mailbox string
	// options
}

pub struct SelectData {}

pub fn (mail Mail) select_(params SelectParams) !SelectData {
	return SelectData{}
}

pub struct CreateOptions {
	mailbox string
}

pub fn (mail Mail) create(options CreateOptions) ! {}

pub fn (mail Mail) delete(mailbox string) ! {}

pub struct RenameParams {
	mailbox  string
	new_name string
}

pub fn (mail Mail) rename(params RenameParams) ! {}

pub fn (mail Mail) subscribe(mailbox string) ! {}

pub fn (mail Mail) unsubscribe(mailbox string) ! {}

pub struct ListOptions {
	patterns []string
}

pub fn (mail Mail) list(options ListOptions) ! {
}

pub struct StatusOptions {
	mailbox string
}

pub struct StatusData {}

pub fn (mail Mail) status(options StatusOptions) !StatusData {
	return StatusData{}
}

pub struct AppendOptions {
	mailbox string
}

pub struct AppendData {}

pub fn (mail Mail) append(options AppendOptions) !AppendData {
	return AppendData{}
}

pub fn (mail Mail) poll(allow_expunge bool) ! {}

pub fn (mail Mail) idle() ! {}
