WORKDIR=/opt/app/contents

start:
	docker-compose up --detach --build app

stop:
	docker-compose down

dev:
	docker-compose run --rm -w $(WORKDIR) -p 3001:3001 -p 3002:3002 app sh -c "npm install && npm run dev"

unitTest:
	docker-compose run --rm -w $(WORKDIR) app sh -c "npm install && npm test"

shell:
	docker-compose run --rm -w $(WORKDIR) app sh -c "npm install && sh"

shelll:
	docker-compose run --rm -w $(WORKDIR) app sh

logs:
	docker logs basic-docker_app_1

goInside:
	docker exec -it --workdir=$(WORKDIR) basic-docker_app_1 sh