include .env
export

IMAGE_NAME=$$dockerImageRepoUser/basic-nodejs-api
IMAGE_HASH_TAG=$(IMAGE_NAME):$(SUBMODULE_HASH)
IMAGE_LATEST_TAG=$(IMAGE_NAME):LATEST
APP_DIR=basic-nodejs-api
WORKDIR=/opt/app/contents
SUBMODULE_HASH=$$(cd $(APP_DIR) && git log -1 --pretty=%h)

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
	docker-compose logs

exec:
	docker-compose exec -w $(WORKDIR) app sh


################################################
# Building for deployable (to production) images
################################################
startImage:
	docker run --name basic-nodejs-api_app --rm -p 3001:3001 -p 3002:3002 $(IMAGE_HASH_TAG) npm start

pullImage:
	make _dockerLogin
	docker pull $(IMAGE_HASH_TAG)
	make _dockerLogout

pushImage:
	make _dockerLogin
	docker push $(IMAGE_NAME)
	make _dockerLogout

buildImage:
	make _updateSubmodule
	docker build -t $(IMAGE_HASH_TAG) -t $(IMAGE_LATEST_TAG) -f ./app.dockerfile ./$(APP_DIR)

_updateSubmodule:
	cd $(APP_DIR) && \
	git pull

_dockerLogin:
	docker login -u $$dockerImageRepoUser -p $$dockerImageRepoPassword

_dockerLogout:
	docker logout
