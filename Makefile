run:
	docker-compose run --rm app make _installDep

shell:
	docker-compose run --rm app /bin/ash

_installDep:
	ls