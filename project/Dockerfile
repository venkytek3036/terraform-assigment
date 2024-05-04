FROM mhart/alpine-node:12

# Create app directory
WORKDIR /usr/src/app

COPY /project/package*.json ./

RUN npm install
COPY ./project .

EXPOSE 8080
CMD [ "node", "server.js" ]