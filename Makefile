IMAGE_NAME := docker.pkg.github.com/peaceiris/actions-label-commenter/alc-dev:latest
NODE_VERSION := $(shell cat ./.nvmrc)

.PHONY: build
build:
	docker-compose build --build-arg NODE_VERSION=$(NODE_VERSION)

.PHONY: run
run:
	docker-compose run --rm dev bash

.PHONY: ci
ci:
	docker-compose run --rm -T dev npm ci

.PHONY: test
test:
	docker-compose run --rm -T dev npm test

.PHONY: all
all:
	docker-compose run --rm -T dev npm run all

.PHONY: release
release:
	bash ./scripts/release.sh

.PHONY: pre-release
pre-release:
	bash ./scripts/pre-release.sh

.PHONY: remove-pre-release
remove-pre-release:
	git rm -f ./lib/index.js
	git commit -m "chore: remove lib/index.js"
