FROM node:8.0-alpine

RUN apk update && apk add ca-certificates wget && update-ca-certificates

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64
RUN chmod +x /usr/local/bin/dumb-init

WORKDIR /var/lib/docker-intro
COPY package.json .
RUN apk --no-cache add --virtual native-deps \
  g++ gcc libgcc libstdc++ linux-headers make python && \
  npm install --quiet node-gyp -g &&\
  npm install --quiet && \
  apk del native-deps
WORKDIR /opt/docker-intro
COPY . /opt/docker-intro
ENV NODE_PATH /var/lib/docker-intro/node_modules:$NODE_PATH


EXPOSE 8000

CMD ["/usr/local/bin/dumb-init", "npm", "start"]
