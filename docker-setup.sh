#!/bin/bash

# This script will setup our workstation with the latest version of docker and
# setup some helpful environment variables to save us some typing

# TODO: deal with sudo?

# fetch the repository key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

echo "deb https://get.docker.io/ubuntu docker main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install lxc-docker

# setup environment variables

