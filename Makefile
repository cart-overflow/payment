SHELL = /bin/bash

# Set up development environment
setup:
	@lefthook install
	@echo "✅ Development environment ready"

# Run Payment Service application
run:
	@echo "🚀 Running Payment Service ..."
	@set -a && source ./.env && go run ./...

# Run Payment Service dependencies
dev:
	@echo "📦 Starting Payment Service dependencies..."
	@docker compose down
	@docker compose up -d

# Stop Payment Service dependencies
down:
	@echo "✋ Shutting down Service Payment dependencies..."
	@docker compose down

# Integration tests
itest:
	@echo "🧪 Testing Payment Service ..."
	@go clean -testcache
	@go test -v -run Integration ./...
	@echo "✅ Tests passed"

# Format Go code using golangci-lint
fmt:
	@echo "🔧 Formatting Go code..."
	@golangci-lint fmt
	@echo "✅ Code formatting complete"

# Run linter checks using gloangci-lint
lint:
	@echo "🔨 Running linter checks..."
	@golangci-lint run
	@echo "✅ Linting complete"

# Fix linting if possible and format the source code
fix: 
	@echo "🛠️ Fix linter issues and formatting the code..."
	@golangci-lint run --fix
	@echo "✅ Fixing complete"

# CI Build discarding artefacts
check-build:
	@echo ⏳ "Building..."
	@go build -o /dev/null ./...
	@echo "✅ Building complete"

# Creates a new migration
migration:
ifndef name
	$(error ❌ Name is required. Usage: make migration name=migration-name)
endif
	migrate create -seq -ext=.sql -dir=./migrations $(name)

.PHONY: setup run dev down itest fmt lint fix check-build migration