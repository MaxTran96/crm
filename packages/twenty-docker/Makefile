prod-build:
	@cd ../.. && docker build -f ./packages/twenty-docker/twenty/Dockerfile --tag max-crm . && cd -

prod-run:
	@docker run -d -p 3000:3000 --name twenty max-crm

prod-postgres-run:
	@docker run -d -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres --name twenty-postgres twenty-postgres

prod-website-build:
	@cd ../.. && docker build -f ./packages/twenty-docker/twenty-website/Dockerfile --tag twenty-website . && cd -

prod-website-run:
	@docker run -d -p 3000:3000 --name twenty-website twenty-website
