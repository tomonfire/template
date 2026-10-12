# Uniform task interface (same targets in every stack): make help
.DEFAULT_GOAL := help
.PHONY: help setup dev lint format test build run ci docker-build docker-run

IMAGE ?= app:local

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

setup: ## Install dependencies
	uv sync --locked

dev: ## Run with auto-reload
	uv run uvicorn app.main:app --reload --port 8080

lint: ## Lint, format check, type check
	uv run ruff check .
	uv run ruff format --check .
	uv run mypy

format: ## Auto-format code
	uv run ruff format .
	uv run ruff check --fix .

test: ## Run tests
	uv run pytest

build: ## Build wheel + sdist
	uv build

run: ## Run the app
	uv run uvicorn app.main:app --host 0.0.0.0 --port 8080

ci: setup lint test build ## Everything CI runs

docker-build: ## Build the container image
	docker build -t $(IMAGE) .

docker-run: docker-build ## Run the container on :8080
	docker run --rm -p 8080:8080 $(IMAGE)
