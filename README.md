# basic-docker
Basic usage of docker by using 3 musketeers methodology https://3musketeers.io/docs/get-started/
You may take a look in the `Makefile`, `docker-compose.yml` and `app.dockerfile` files to better understand the implementation.

# initialize the submodule first
`git submodule init`
`git submodule update`

This repo uses the app in the repo `https://github.com/lesterbp/basic-nodejs-api` as its submodule and dockerizes it. You'll need to initialize and update the submodule before you do anything else.

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


# having a deployable (to production) image
The best thing about using docker is deploying the same image in all environments. This is great in doing CD (continuous delivery) for your project because every environment is consistent and works at the same way.

## build image
`make buildImage`

Building the docker image is the first part. Take a look at `app.dockerfile` it list down the base image that will be used for the app, copy some source codes and install the dependencies. The `buildImage` in the Makefile will first update the submodule where our app is and gets the git commit short hash to be used in tagging the docker image.

## push image
`make pushImage`

Once the docker image is built, you will need to push it to a docker image repo which in this case I have setup a private repo in my dockerHub. You will need to create a `.env` file based on the `.env.template` and fill up the variables which is used in this process.

## pull image
`make pullImage`

Usually, you will need to pull a docker image from a different machine or environment and the particular `Makefile` that we have here is not available. In that case, have a look inside the `Makefile` for the commands used in `pullImage` as a reference.

## start image
`make startImage`

If it will be the same situation with `make pullImage` that the `Makefile` is not available in the current environment. You may just use the commands used in the `make startImage` as a reference on how to start the pulled docker image.
