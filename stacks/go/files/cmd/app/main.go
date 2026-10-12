package main

import (
	"log"
	"net/http"
	"os"
	"time"

	"example.com/app/internal/server"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	srv := &http.Server{
		Addr:              ":" + port,
		Handler:           server.New(),
		ReadHeaderTimeout: 10 * time.Second,
	}
	log.Printf("listening on http://localhost:%s", port)
	log.Fatal(srv.ListenAndServe())
}
