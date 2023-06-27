package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"context"
	"github.com/emersion/go-webdav/caldav"
	"github.com/emersion/go-ical"
)

type contextKey string

var (
	currentUserPrincipalKey = contextKey("/calendar/dav/test/user/")
)

type Backend struct {
	S string
}

// This method means type T implements the interface I,
// but we don't need to explicitly declare that it does so.
func (b Backend) CalendarHomeSetPath(ctx context.Context) (string, error) {
	return "/", nil
}

func (b Backend) Calendar(ctx context.Context) (*caldav.Calendar, error) {
	return new(caldav.Calendar), nil
}
func (b Backend) GetCalendarObject(ctx context.Context, path string, req *caldav.CalendarCompRequest) (*caldav.CalendarObject, error) {
	return new(caldav.CalendarObject), nil
}
func (b Backend) ListCalendarObjects(ctx context.Context, req *caldav.CalendarCompRequest) ([]caldav.CalendarObject, error) {
	return []caldav.CalendarObject{}, nil
}
func (b Backend) QueryCalendarObjects(ctx context.Context, query *caldav.CalendarQuery) ([]caldav.CalendarObject, error) {
	return []caldav.CalendarObject{}, nil
}
func (b Backend) PutCalendarObject(ctx context.Context, path string, calendar *ical.Calendar, opts *caldav.PutCalendarObjectOptions) (loc string, err error) {
	return "", nil
}
func (b Backend) DeleteCalendarObject(ctx context.Context, path string) error {
	return nil
}

func (b Backend) CurrentUserPrincipal(ctx context.Context) (string, error) {
	r := ctx.Value(currentUserPrincipalKey).(string)
	return r, nil
}

func main() {
	var addr string
	flag.StringVar(&addr, "addr", ":8082", "listening address")
	flag.Usage = func() {
		fmt.Fprintf(flag.CommandLine.Output(), "usage: %s [options...] [directory]\n", os.Args[0])
		flag.PrintDefaults()
	}
	flag.Parse()

	path := flag.Arg(0)
	if path == "" {
		path = "."
	}

	handler := caldav.Handler{
		Backend: Backend{},
	}
	log.Printf("CalDAV server listening on %v", addr)
	log.Fatal(http.ListenAndServe(addr, &handler))
}
