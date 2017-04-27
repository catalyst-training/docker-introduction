FROM node:6

WORKDIR /opt/docker-intro
COPY slides /opt/docker-intro/

RUN npm i

EXPOSE 8000

CMD ["npm", "start"]
