# basic-docker
Basic usage of docker by using 3 musketeers methodology https://3musketeers.io/docs/get-started/
This repo uses the app in the repo `/lesterbp/basic-nodejs-api` as its submodule and dockerizes it.
You may take a look in the `Makefile` and `docker-compose.yml` files to better understand the implementation.

# running the app
`make start`

# stopping the app
`make stop`

# running the app in dev mode
`make dev`

This will run the app that includes dev dependencies and auto restart when files have changed.

# shell into a new container
`make shell`

When doing this `npm install` automatically run so that it's ready for you to run any app related commands like `npm run linter` or `npm test` inside the shell


`make shelll`

Same as `make shell` but will not run `npm install` thus the extra "l" in the shelll because it's a bit lighter ;-)

# print the logs of the containers
`make logs`

# go inside the actual running app container
`make exec`

Goes inside the started app. Might be useful when you want to take a look inside the container of a running app.
