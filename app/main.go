package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"strings"
)

var (
	solved    = map[string][]string{"e1": {}, "e2a": {}, "e2b": {}, "e3": {}, "e4": {}}
	solutions = map[string]string{
		"e1":  "UDNTJAM176,0.02,DE,Germany",
		"e2a": "PL|635.91",
		"e2b": "PL|635.91",
		"e3":  "Finland,299295.09000000556",
		"e4":  "Peru,299400.77000000514",
	}
)

const (
	RESP_OK        = "🙂 Valid!"
	RESP_MALFORMED = "🙆🏻‍♂️ Malformed request"
	RESP_INCORRECT = "🥕 Incorrect Answer"
)

func getSolutions(w http.ResponseWriter, r *http.Request) {
	log.Printf("%s %s", r.Method, r.URL.Path)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(solved)
}

func postSolution(w http.ResponseWriter, r *http.Request) {
	log.Printf("%s %s", r.Method, r.URL.Path)
	parts := strings.Split(r.URL.Path, "/")
	if len(parts) != 4 {
		http.Error(w, "Error", http.StatusBadRequest)
		return
	}
	team, exercise := parts[2], parts[3]
	body, err := io.ReadAll(r.Body)
	defer r.Body.Close()

	if err != nil || team == "" || exercise == "" || solutions[exercise] == "" {
		http.Error(w, RESP_MALFORMED, http.StatusBadRequest)
		return
	}

	if solutions[exercise] != string(body) {
		http.Error(w, RESP_INCORRECT, http.StatusUnprocessableEntity)
		return
	}

	solved[exercise] = append(solved[exercise], team)
	fmt.Fprintln(w, RESP_OK)
}

func main() {
	http.HandleFunc("/api/solved", getSolutions)
	http.HandleFunc("/api/", postSolution)
	http.Handle("/", http.FileServer(http.Dir("/docs")))

	log.Printf("Listening on port 3000")
	log.Fatal(http.ListenAndServe(":3000", nil))
}
