
go run imap_server.go -listen localhost:8080 -username test -password test -insecure-auth true &
go run webdav_server.go &
go run caldav_server.go
