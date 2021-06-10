SHELL = /bin/sh

.PHONY: bash
bash:
	docker-compose -f docker-compose.yml run app-local bash

.PHONY: test-up
test-up:
	docker-compose -f docker-compose.yml up -d --force-recreate --build

.PHONY: down
down:
	docker-compose -f docker-compose.yml down --remove-orphans

.PHONY: test
test: test-up
	docker-compose -f docker-compose.yml run --rm app bundle exec rspec

.PHONY: rubocop
rubocop: test-up
	docker-compose -f docker-compose.yml run --rm app bundle exec rubocop

.PHONY: fasterer
fasterer: test-up
	docker-compose -f docker-compose.yml run --rm app bundle exec fasterer

.PHONY: bundle-audit
bundle-audit: test-up
	docker-compose -f docker-compose.yml run --rm app bundle exec bundle-audit --update
