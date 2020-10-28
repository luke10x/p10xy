up-agent:
	docker-compose up -d --force-recreate agent

up-target:
	docker-compose up -d --force-recreate target

up: up-target up-agent

logs:
	docker-compose logs -f

install-agent:
	docker-compose run --rm agent "npm install"

install-target:
	docker-compose run --rm target "npm install"

install: install-agent

into-agent:
	docker-compose exec agent bash

into-target:
	docker-compose exec target bash

bash-agent:
	docker-compose run agent bash

ash-target:
	docker-compose run target bash

lint-agent:
	docker-compose run --rm agent "npm run lint"

lint: lint-agent

test-agent:
	docker-compose run --rm agent "npm run test:unit -- --verbose"

test: test-agent

push-agent:
	docker build

down:
	docker-compose down

unrootify:
	sudo chown -R $$(id -u):$$(id -g) .
