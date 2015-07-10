#!/bin/bash

# This script will setup our workstation with the latest version of docker

if [[ $EUID -ne 0 ]];
then
    echo
    echo "Usage: sudo ./docker-setup.sh"
    echo
    exit 1
fi

cd /tmp

# ensure we have the right sources source
DOCKER_SOURCE=/etc/apt/sources.list.d/docker.list

if [ ! -f $DOCKER_SOURCE ];
then
    # fetch the repository key
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

    echo "deb https://get.docker.io/ubuntu docker main" > $DOCKER_SOURCE
fi

# ensure we have docker installed
INSTALL_STATUS=$(dpkg -s lxc-docker | grep Status | awk '{ print $3}')

if [[ ! $INSTALL_STATUS = 'ok' ]];
then
    apt-get update
    apt-get install lxc-docker
fi

# install dockviz
DOCKVIZ_BIN=/usr/local/bin/dockviz
if [ ! -f $DOCKVIZ_BIN ];
then
    wget https://github.com/justone/dockviz/releases/download/v0.2/dockviz_linux_amd64
    chmod 755 dockviz_linux_amd64
    mv dockviz_linux_amd64 $DOCKVIZ_BIN
fi

# install docker-compose
COMPOSE_BIN=/usr/local/bin/docker-compose
if [ ! -f $COMPOSE_BIN ];
then
    wget https://github.com/docker/compose/releases/download/1.2.0/docker-compose-linux-x86_64
    chmod 755 docker-compose-linux-x86_64
    mv docker-compose-linux-x86_64 $COMPOSE_BIN
fi

# install kubectl
KUBECTL_BIN=/usr/local/bin/kubectl
if [ ! -f $KUBECTL_BIN ];
then
    wget http://storage.googleapis.com/kubernetes-release/release/v0.14.1/bin/linux/amd64/kubectl
    chmod 755 kubectl
    mv kubectl $KUBECTL_BIN
fi
