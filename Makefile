include .env
export

APPLICATION=basic-nodejs-api
CONTAINER_NAME=$(APPLICATION)_app
IMAGE_NAME=$$DOCKER_REPO_USERNAME/$(APPLICATION)
IMAGE_HASH_TAG=$(IMAGE_NAME):$(SUBMODULE_HASH)
IMAGE_LATEST_TAG=$(IMAGE_NAME):LATEST
SUBMODULE_HASH=$$(cd $(APPLICATION) && git log -1 --pretty=%h)

# This is part of the 3 musketeers guide
# to import the application's environment variables to the container
# to be used in running "deployable image" (`make startImage`)
# you may override an env file to be used `ENVFILE=another.env make startImage`
ifdef ENVFILE
	PREP_ENVFILE=copyEnvfile
else
	# Don't be confused, this executes the target (make command) at the bottom part
	PREP_ENVFILE=$(APPLICATION)/.env
endif

##################################################
# During development (or for non-prod) purposes
##################################################

start: $(PREP_ENVFILE)
	docker-compose up -d --build app

stop:
	docker-compose down

dev: $(PREP_ENVFILE)
	docker-compose run --rm -p 3001:3001 -p 3002:3002 app sh -c "npm install && npm run dev"

unitTest: $(PREP_ENVFILE)
	docker-compose run --rm app sh -c "npm install && npm test"

shell: $(PREP_ENVFILE)
	docker-compose run --rm app sh -c "npm install && sh"

shelll: $(PREP_ENVFILE)
	docker-compose run --rm app sh

logs:
	docker-compose logs

exec:
	docker-compose exec app sh


##################################################
# Building for deployable (production ready) image
##################################################

startImage: $(PREP_ENVFILE)
	docker run --env-file $(APPLICATION)/.env --name $(CONTAINER_NAME) --rm -p 3001:3001 -p 3002:3002 $(IMAGE_HASH_TAG)

pullImage: dockerLogin
	make dockerLogin
	docker pull $(IMAGE_HASH_TAG)

pushImage: dockerLogin
	docker push $(IMAGE_NAME)

buildImage: updateSubmodule
	docker build --no-cache -t $(IMAGE_HASH_TAG) -t $(IMAGE_LATEST_TAG) -f app.dockerfile ./$(APPLICATION)

updateSubmodule:
	cd $(APPLICATION) && \
	git checkout master && \
	git pull

dockerLogin:
	docker login -u $$DOCKER_REPO_USERNAME -p $$DOCKER_REPO_PASSWORD

copyEnvfile:
	cp $(ENVFILE) $(APPLICATION)/.env

# Create application's .env based on .env.template if .env does not exist
# ie. if the .env file in the application dir exist, it won't execute the commands in it
$(APPLICATION)/.env:
	cp $(APPLICATION)/.env.template $(APPLICATION)/.env
