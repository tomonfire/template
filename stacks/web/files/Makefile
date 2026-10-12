# Uniform task interface (same targets in every stack): make help
.DEFAULT_GOAL := help
.PHONY: help setup dev lint format test build run site ci

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

setup: ## Install dependencies
	npm ci

dev: ## Start dev server with live reload → http://localhost:8080
	npm run dev

lint: ## Lint, format check, type check
	npm run lint

format: ## Auto-format code
	npm run format

test: ## Run tests
	npm test

build: ## Build the website into site/
	npm run build

site: build ## Static website for GitHub Pages (output: site/)

run: build ## Serve the built website → http://localhost:8080
	npm run preview

ci: setup lint test build ## Everything CI runs
