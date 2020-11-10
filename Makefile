.PHONY: postgres-up
postgres-up: build 
	docker-compose up

.PHONY: postgres-up-bg 
postgres-up-bg: build 
	docker-compose up -d

.PHONY: postgres-down 
postgres-down: 
	docker-compose down

.PHONY: build 
build: 
	docker-compose build

.PHONY: postgres-down-force
postgres-down-force: 
	docker-compose down --remove-orphans

.PHONY: postgres-logs
postgres-logs:
	docker-compose logs -f postgres