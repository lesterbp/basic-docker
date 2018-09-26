start:
	docker-compose up --detach --build app

stop:
	docker-compose down

unitTest:
	docker-compose run --rm --workdir="/opt/app/contents" app sh -c "npm install && npm test"

shell:
	docker-compose run --rm --workdir="/opt/app/contents" app sh -c "npm install && sh"

shelll:
	docker-compose run --rm --workdir="/opt/app/contents" app sh

logs:
	docker logs basic-docker_app_1

goInside:
	docker exec -it --workdir="/opt/app/contents" basic-docker_app_1 sh