module openrpc

import log
import freeflowuniverse.crystallib.jsonrpc
import freeflowuniverse.crystallib.rpcwebsocket
import x.json2
import mail { AppendData, AppendOptions, CreateOptions, ListOptions, LoginParams, RenameParams, SelectData, SelectParams, StatusData, StatusOptions }

// client for reverse echo json rpc ws server
struct CustomJsonRpcClient {
	jsonrpc.JsonRpcClient
}

pub fn (mut client CustomJsonRpcClient) close() ! {
	_ := client.send_json_rpc[string, json2.Null]('close', '', 1000)!
}

pub fn (mut client CustomJsonRpcClient) login(params LoginParams) ! {
	_ := client.send_json_rpc[LoginParams, json2.Null]('login', params, 1000)!
}

pub fn (mut client CustomJsonRpcClient) select_(params SelectParams) !SelectData {
	return client.send_json_rpc[SelectParams, SelectData]('select_', params, 1000)!
}

pub fn (mut client CustomJsonRpcClient) create(options CreateOptions) ! {
	_ := client.send_json_rpc[CreateOptions, json2.Null]('create', options, 1000)!
}

pub fn (mut client CustomJsonRpcClient) delete(mailbox string) ! {
	_ := client.send_json_rpc[string, json2.Null]('delete', mailbox, 1000)!
}

pub fn (mut client CustomJsonRpcClient) rename(params RenameParams) ! {
	_ := client.send_json_rpc[RenameParams, json2.Null]('rename', params, 1000)!
}

pub fn (mut client CustomJsonRpcClient) subscribe(mailbox string) ! {
	_ := client.send_json_rpc[string, json2.Null]('subscribe', mailbox, 1000)!
}

pub fn (mut client CustomJsonRpcClient) unsubscribe(mailbox string) ! {
	_ := client.send_json_rpc[string, json2.Null]('unsubscribe', mailbox, 1000)!
}

pub fn (mut client CustomJsonRpcClient) list(options ListOptions) ! {
	_ := client.send_json_rpc[ListOptions, json2.Null]('list', options, 1000)!
}

pub fn (mut client CustomJsonRpcClient) status(options StatusOptions) !StatusData {
	return client.send_json_rpc[StatusOptions, StatusData]('status', options, 1000)!
}

pub fn (mut client CustomJsonRpcClient) append(options AppendOptions) !AppendData {
	return client.send_json_rpc[AppendOptions, AppendData]('append', options, 1000)!
}

pub fn (mut client CustomJsonRpcClient) poll(allow_expunge bool) ! {
	_ := client.send_json_rpc[bool, json2.Null]('poll', allow_expunge, 1000)!
}

pub fn (mut client CustomJsonRpcClient) idle() ! {
	_ := client.send_json_rpc[string, json2.Null]('idle', '', 1000)!
}

// run_client creates and runs jsonrpc client
// uses reverse_echo method to perform rpc and prints result
pub fn new_client(mut transport rpcwebsocket.RpcWsClient) !&CustomJsonRpcClient {
	mut logger := log.Logger(&log.Log{
		level: .debug
	})

	mut client := CustomJsonRpcClient{
		transport: transport
	}
	spawn transport.run()
	return &client
}
