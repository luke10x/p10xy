up-agent:
	docker-compose up -d --force-recreate agent

up-webapp:
	docker-compose up -d --force-recreate webapp

up-target:
	docker-compose up -d --force-recreate target

up: up-target up-agent up-webapp

logs:
	docker-compose logs -f

install-agent:
	docker-compose run --rm agent "npm install"

install-webapp:
	docker-compose run --rm webapp "npm install"

install-target:
	docker-compose run --rm target "npm install"

install: install-agent install-webapp

into-agent:
	docker-compose exec agent bash

into-webapp:
	docker-compose exec webapp bash

into-target:
	docker-compose exec target bash

bash-agent:
	docker-compose run agent bash

bash-webapp:
	docker-compose run webapp bash

bash-target:
	docker-compose run target bash

lint-agent:
	docker-compose run --rm agent "npm run lint"

lint-webapp:
	docker-compose run --rm webapp "npm run lint"

lint: lint-agent

test-agent:
	docker-compose run --rm agent "npm test -- --verbose"

test-webapp:
	docker-compose run --rm webapp "npm test -- --verbose"

test: test-agent test-webapp

down:
	docker-compose down

unrootify:
	sudo chown -R $$(id -u):$$(id -g) .
