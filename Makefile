start:
	docker-compose up --detach --build app

stop:
	docker-compose down

shell:
	docker-compose run --rm app /bin/ash

# This assumes that the container name is basic-docker_app_1
# but it could sometimes change
# you may do `docker ps` to list down all running containers
logs:
	docker logs basic-docker_app_1