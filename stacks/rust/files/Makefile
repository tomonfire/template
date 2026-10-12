# Uniform task interface (same targets in every stack): make help
.DEFAULT_GOAL := help
.PHONY: help setup dev lint format test build run ci docker-build docker-run

IMAGE ?= app:local

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

setup: ## Fetch dependencies
	cargo fetch --locked

dev: ## Run the app
	cargo run

lint: ## rustfmt check + clippy (warnings are errors)
	cargo fmt --all --check
	cargo clippy --all-targets --locked -- -D warnings

format: ## Auto-format code
	cargo fmt --all

test: ## Run tests
	cargo test --locked

build: ## Release build
	cargo build --release --locked

run: build ## Run the release binary
	./target/release/app

ci: setup lint test build ## Everything CI runs

docker-build: ## Build the container image
	docker build -t $(IMAGE) .

docker-run: docker-build ## Run the container on :8080
	docker run --rm -p 8080:8080 $(IMAGE)
