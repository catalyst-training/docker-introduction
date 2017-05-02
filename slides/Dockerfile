FROM node:6

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64
RUN chmod +x /usr/local/bin/dumb-init

WORKDIR /usr/local/node-libs
COPY package.json /usr/local/node-libs
RUN npm install
ENV NODE_PATH /usr/local/node-libs/node_modules

WORKDIR /opt/docker-intro
COPY . /opt/docker-intro

RUN npm i

EXPOSE 8000

CMD ["/usr/local/bin/dumb-init", "npm", "start"]
