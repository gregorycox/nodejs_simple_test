FROM alpine:3.4

# Update
RUN apk add --update nodejs bash

# Create app directory
RUN mkdir -p /usr/src/app/test
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY [ "test", "index.js", "time.js", "/usr/src/app/"]
COPY [ "test/", "/usr/src/app/test/"]


#EXPOSE 8080
CMD [ "node", "index.js" ]
