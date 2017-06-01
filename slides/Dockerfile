FROM node:8.0-alpine


RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64
RUN chmod +x /usr/local/bin/dumb-init

WORKDIR /opt/docker-intro
COPY . /opt/docker-intro
RUN  npm install


EXPOSE 8000

CMD ["/usr/local/bin/dumb-init", "npm", "start"]
