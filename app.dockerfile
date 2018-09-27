FROM node:8-alpine

WORKDIR /opt/app/basic-nodejs-api

COPY src ./src
COPY package-lock.json .
COPY package.json .

RUN npm cache verify \
  && npm install --prod

EXPOSE 3001 3002

# ENTRYPOINT may also be used
# but CMD can give a bit more flexibility if user want to override
CMD [ "npm", "start" ]
