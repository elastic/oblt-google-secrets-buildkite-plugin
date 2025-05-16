.PHONY: all
all: tests lint

.PHONY: tests
tests:
	@docker compose run --rm tests

.PHONY: lint
lint:
	@docker compose run lint
