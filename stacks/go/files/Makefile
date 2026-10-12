# Uniform task interface (same targets in every stack): make help
.DEFAULT_GOAL := help
.PHONY: help setup dev lint format test build run ci docker-build docker-run

IMAGE ?= app:local

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

setup: ## Download dependencies
	go mod download

dev: ## Run the app
	go run ./cmd/app

lint: ## gofmt check + go vet
	@test -z "$$(gofmt -l .)" || (gofmt -l . && echo "run: make format" && exit 1)
	go vet ./...

format: ## Auto-format code
	gofmt -w .

test: ## Run tests (with race detector)
	go test -race ./...

build: ## Build binary to bin/app
	CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o bin/app ./cmd/app

run: build ## Run the built binary
	./bin/app

ci: setup lint test build ## Everything CI runs

docker-build: ## Build the container image
	docker build -t $(IMAGE) .

docker-run: docker-build ## Run the container on :8080
	docker run --rm -p 8080:8080 $(IMAGE)
