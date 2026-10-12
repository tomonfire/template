# Uniform task interface (same targets in every stack): make help
.DEFAULT_GOAL := help
.PHONY: help setup dev lint format test build run ci docker-build docker-run

IMAGE ?= app:local
MVN ?= mvn -B -ntp

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

setup: ## Resolve dependencies
	$(MVN) -q dependency:go-offline

dev: build ## Run the app
	java -jar target/app.jar

lint: ## Compile with all warnings as errors
	$(MVN) -q compile test-compile

format: ## (add a formatter, e.g. spotless, when needed)
	@echo "no formatter configured"

test: ## Run tests
	$(MVN) test

build: ## Package the jar
	$(MVN) -q package -DskipTests

run: build ## Run the packaged jar
	java -jar target/app.jar

ci: setup lint test build ## Everything CI runs

docker-build: ## Build the container image
	docker build -t $(IMAGE) .

docker-run: docker-build ## Run the container on :8080
	docker run --rm -p 8080:8080 $(IMAGE)
