FROM node:8-alpine

WORKDIR /opt/app/basic-nodejs-api

COPY src ./src
COPY package-lock.json ./package-lock.json
COPY package.json ./package.json

RUN npm cache verify \
  && npm install --prod
