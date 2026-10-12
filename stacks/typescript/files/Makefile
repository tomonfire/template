# Uniform task interface (same targets in every stack): make help
.DEFAULT_GOAL := help
.PHONY: help setup dev lint format test build run ci docker-build docker-run

IMAGE ?= app:local

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

setup: ## Install dependencies
	npm ci

dev: ## Run with auto-reload
	npm run dev

lint: ## Lint, format check, type check
	npm run lint

format: ## Auto-format code
	npm run format

test: ## Run tests
	npm test

build: ## Build production artifacts
	npm run build

run: build ## Run the built app
	npm start

ci: setup lint test build ## Everything CI runs

docker-build: ## Build the container image
	docker build -t $(IMAGE) .

docker-run: docker-build ## Run the container on :8080
	docker run --rm -p 8080:8080 $(IMAGE)
