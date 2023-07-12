module openrpc

import log
import json
import freeflowuniverse.crystallib.jsonrpc { jsonrpcrequest_decode }
import freeflowuniverse.crystallib.openrpc as crystallib_openrpc { OpenRpcHandler }
import freeflowuniverse.crystallib.rpchandler
import mail { AppendOptions, CreateOptions, ListOptions, LoginParams, Mail, RenameParams, SelectParams, StatusOptions }

struct CustomOpenRpcHandler {
	OpenRpcHandler
}

fn (mut handler CustomOpenRpcHandler) close_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := json.decode(jsonrpc.JsonRpcRequestAny, data)!
	receiver.close()!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) login_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[LoginParams](data)!
	receiver.login(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) select__handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[SelectParams](data)!
	receiver.select_(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) create_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[CreateOptions](data)!
	receiver.create(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) delete_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[string](data)!
	receiver.delete(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) rename_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[RenameParams](data)!
	receiver.rename(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) subscribe_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[string](data)!
	receiver.subscribe(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) unsubscribe_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[string](data)!
	receiver.unsubscribe(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) list_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[ListOptions](data)!
	receiver.list(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) status_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[StatusOptions](data)!
	receiver.status(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) append_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[AppendOptions](data)!
	receiver.append(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) poll_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := jsonrpcrequest_decode[bool](data)!
	receiver.poll(request.params)!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

fn (mut handler CustomOpenRpcHandler) idle_handle(data string) !string {
	mut receiver := &Mail(handler.state)

	request := json.decode(jsonrpc.JsonRpcRequestAny, data)!
	receiver.idle()!

	response := jsonrpc.JsonRpcResponse[string]{
		jsonrpc: '2.0.0'
		id: request.id
		result: ''
	}
	return response.to_json()
}

pub struct HandlerParams {
	logger       &log.Logger
	state        voidptr
	openrpc_path string
}

// run_server creates and runs a jsonrpc ws server
// handles rpc requests to reverse_echo function
pub fn new_handler(params HandlerParams) !&CustomOpenRpcHandler {
	mut handler := CustomOpenRpcHandler{
		OpenRpcHandler: crystallib_openrpc.new_handler(params.logger, params.openrpc_path)!
	}

	handler.state = params.state
	// register rpc methods
	handler.register('close', handler.close_handle)!
	handler.register('login', handler.login_handle)!
	handler.register('select_', handler.select__handle)!
	handler.register('create', handler.create_handle)!
	handler.register('delete', handler.delete_handle)!
	handler.register('rename', handler.rename_handle)!
	handler.register('subscribe', handler.subscribe_handle)!
	handler.register('unsubscribe', handler.unsubscribe_handle)!
	handler.register('list', handler.list_handle)!
	handler.register('status', handler.status_handle)!
	handler.register('append', handler.append_handle)!
	handler.register('poll', handler.poll_handle)!
	handler.register('idle', handler.idle_handle)!

	return &handler
}
