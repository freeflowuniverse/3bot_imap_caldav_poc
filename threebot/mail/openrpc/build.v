module openrpc

import freeflowuniverse.crystallib.jsonrpc
import freeflowuniverse.crystallib.openrpc as crystallib_openrpc
import freeflowuniverse.crystallib.openrpc.docgen
import os

pub fn build() ! {
	dir := os.dir(@FILE)

	docgen.docgen(
		title: '3Bot Mail JSON-RPC API'
		source: os.dir(dir)
		only_pub: true
	)!

	// crystallib_openrpc.handlergen(
	// 	mod: 'openrpc'
	// 	filename: 'handler'
	// 	title: '3Bot Mail JSON-RPC API'
	// 	source: os.dir(dir)
	// 	destination: dir
	// 	only_pub: true
	// 	openrpc_path: '${dir}/openrpc.json'
	// 	recursive: false
	// )!

	// jsonrpc.clientgen(
	// 	// mod: 'openrpc'
	// 	// filename: 'handler'
	// 	source: os.dir(dir)
	// 	recursive: false
	// 	destination: dir
	// 	only_pub: true
	// )!
}
