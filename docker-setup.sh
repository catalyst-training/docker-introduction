#!/bin/bash

# This script will setup our workstation with the latest version of docker

if [[ $EUID -ne 0 ]];
then
    echo
    echo "Usage: sudo ./docker-setup.sh"
    echo
    exit 1
fi

cd /tmp || exit

# ensure we have the right sources source
DOCKER_SOURCE=/etc/apt/sources.list.d/docker.list

if [ ! -f $DOCKER_SOURCE ];
then
    # fetch the repository key
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > $DOCKER_SOURCE
fi

# ensure we have docker installed
INSTALL_STATUS=$(dpkg -s docker-engine | grep Status | awk '{ print $3 }')

if [[ ! $INSTALL_STATUS = 'ok' ]];
then
    apt-get update
    apt-get install -y docker-engine
fi

# install dockviz
DOCKVIZ_BIN=/usr/local/bin/dockviz
if [ ! -f $DOCKVIZ_BIN ];
then
    wget https://github.com/justone/dockviz/releases/download/v0.2.1/dockviz_linux_amd64
    chmod 755 dockviz_linux_amd64
    mv dockviz_linux_amd64 $DOCKVIZ_BIN
    apt-get install -y graphviz
fi

# install docker-compose
COMPOSE_BIN=/usr/local/bin/docker-compose
if [ ! -f $COMPOSE_BIN ];
then
    wget https://github.com/docker/compose/releases/download/1.5.1/docker-compose-linux-x86_64
    chmod 755 docker-compose-linux-x86_64
    mv docker-compose-linux-x86_64 $COMPOSE_BIN
fi

# install kubectl
KUBECTL_BIN=/usr/local/bin/kubectl
if [ ! -f $KUBECTL_BIN ];
then
    wget http://storage.googleapis.com/kubernetes-release/release/v1.1.1/bin/linux/amd64/kubectl
    chmod 755 kubectl
    mv kubectl $KUBECTL_BIN
fi

# install sysdig
SYSDIG_BIN=/usr/bin/sysdig
if [ ! -f $SYSDIG_BIN ];
then
    curl -s https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public | apt-key add -
    curl -s -o /etc/apt/sources.list.d/draios.list http://download.draios.com/stable/deb/draios.list
    apt-get update
    apt-get -y install linux-headers-$(uname -r)
    apt-get -y install sysdig
fi

# install checkconfig
CHECK_CONFIG_BIN=~/bin/check-config.sh
USER=$(logname)
if [ ! -f $CHECK_CONFIG_BIN ];
then
    echo installing $CHECK_CONFIG_BIN
    mkdir -p ~/bin/
    curl -s -o $CHECK_CONFIG_BIN https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh
    chown $USER:$USER $CHECK_CONFIG_BIN
    chmod 744 $CHECK_CONFIG_BIN
fi

# install htop
HTOP_BIN=/usr/bin/htop
if [ ! -f $HTOP_BIN ];
then
    apt-get install htop
fi
