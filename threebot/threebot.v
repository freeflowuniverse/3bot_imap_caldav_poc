module threebot

import freeflowuniverse.threebot.mail
import freeflowuniverse.threebot.mail.openrpc
import freeflowuniverse.crystallib.rpcwebsocket
import log
// import files

pub struct Threebot {
	// Calendar
	// Files
	mail mail.Mail
}

pub fn (bot Threebot) run() ! {
	// spawn bot.Calendar.run_server()
	// spawn bot.Files.run_server()

	mut logger := log.Logger(&log.Log{
		level: .debug
	})

	mail_handler := openrpc.new_handler(
		logger: &logger
		state: &bot.mail
		openrpc_path: '.'
	)!

	mut jsonrpc_ws_server := rpcwebsocket.new_rpcwsserver(
		8080, 
		mail_handler, 
		&logger)!
	jsonrpc_ws_server.run()!
}

// fn
