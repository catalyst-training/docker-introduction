#!/bin/bash

# This script will setup our workstation with the latest version of docker

if [[ $EUID -ne 0 ]];
then
    echo
    echo "Usage: sudo ./docker-setup.sh"
    echo
    exit 1
fi

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
