package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"
)

func main() {
	arguments := os.Args
	if len(arguments) < 2 {
		fmt.Println("Please provide port...")
		return
	}

	// configure the media directory name and port
	const mediaDir = "media"
	port, _ := strconv.Atoi(arguments[1])

	// add a handler for the media files
	http.Handle("/", addHeaders(http.FileServer(http.Dir(mediaDir))))
	fmt.Printf("Starting server on %v\n", port)
	log.Printf("Serving %s on HTTP port: %v\n", mediaDir, port)

	// serve and log errors
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%v", port), nil))
}

// addHeaders will act as middleware to give us CORS support
func addHeaders(h http.Handler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		h.ServeHTTP(w, r)
	}
}