# basic-docker
Basic usage of docker by using 3 musketeers methodology https://3musketeers.io/docs/get-started/
This repo uses the app in the repo `/lesterbp/basic-nodejs-api` as its submodule and dockerizes it.
You may take a look in the `Makefile` and `docker-compose.yml` files to better understand the implementation.

# running the app
`make start`

# stopping the app
`make stop`

# shell into a new container
`make shell`

When doing this `npm install` automatically run so that it's ready for you to run any app related commands like `npm run linter` or `npm test` inside the shell


`make shelll`

Same as `make shell` but will not run `npm install` thus the extra "l" in the shelll because it's a bit lighter ;-)

# print the logs of the running app container
`make logs`

List down the logs inside the container, this assumes that the container name is basic-docker_app_1 but it could sometimes change. You may do `docker ps` to list down all running containers

# go inside the actual running app container
`make goInside`

Goes inside the started app, it assumes container name is basic-docker_app_1. Might be useful when you want to take a look inside the container of a running app.
