#!/bin/bash

# This script has only been tested on Trusty ...

# TODO check the user has run the setup script, if not warn them and exit
# TODO delete all current docker images on this host before proceeding? This could potentially annoy someone
# TODO add support for sections so we can catchup to a specific section
# TODO add support for a command listing which executes no code (deal with variables)
# TODO move user vars into env, setup via setup.sh
# flags (interactive and breakpoints)

# cat /etc/os-release

if [[ $EUID -ne 0 ]]; then
   echo "Usage: sudo ./docker-course.sh"
   exit 1
fi

EDITOR=/usr/bin/vim
OUR_USER=dojo
DOCKER_AUTHOR="Donovan Jones"
DOCKER_EMAIL="donovan@catalyst.net.nz"
INTERACTIVE=1
function wait_for_keypress {
    if [[ $INTERACTIVE == '1' ]];
    then
        read -n1 -rsp "" key
        if [[ $key == 'q' ]]; then
            echo
            echo "exiting (q for exit)"
            exit;
        fi
    fi
    echo
}

echo "# Cleaning up old containers before we start:"
# check that these containers don't exist
for container in insane_babbage nostalgic_morse dbdata web db db1 db2 db3 web1 web2 web3;
do
    # stop any running containers
    if docker ps | grep -q $container
    then
        docker stop $container
    fi

    # remove containers
    if docker ps -a | grep -q $container
    then
        docker rm $container
    fi
done
echo "Cleaning up images before we start:"
docker rmi -f $( docker images | grep '<none>' | awk '{print $3}' )
sudo docker rmi $OUR_USER/sinatra:devel

# https://docs.docker.com/userguide/dockerizing/
echo -----------------------------------------------------------------
echo -n "# https://docs.docker.com/userguide/dockerizing/"
wait_for_keypress;

# Hello world
echo
echo --------------------------------1.01: Hello world---------------------------------

echo -n "$ sudo docker run ubuntu:14.04 /bin/echo 'Hello world'"
wait_for_keypress;

docker run ubuntu:14.04 /bin/echo 'Hello world'

# An interactive container
# -i, --interactive=false    Keep STDIN open even if not attached
# -t, --tty=false            Allocate a pseudo-TTY
echo
echo --------------------------------1.02: An interactive container---------------------------------

echo "$ sudo docker run -t -i ubuntu:14.04 /bin/bash"
echo -n "# type exit when you are done looking around"
wait_for_keypress;
if [[ $INTERACTIVE == '1' ]];
then
    docker run -t -i ubuntu:14.04 /bin/bash
fi

# A daemonized Hello world
echo
echo --------------------------------1.03: A daemonized Hello world---------------------------------

echo -n '$ sudo docker run --name=insane_babbage -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"'
wait_for_keypress;

# Note the use of --name=insane_babbage which gives us a consistent name
# TODO: check we are not already running insane_babbage before running this
docker run --name=insane_babbage -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"

echo -n '$ sudo docker ps'
wait_for_keypress;
docker ps

echo -n '$ sudo docker logs insane_babbage'
wait_for_keypress;
docker logs insane_babbage | tail -n 10

echo -n '$ sudo docker stop insane_babbage'
wait_for_keypress;
docker stop insane_babbage

echo -n '$ sudo docker ps'
wait_for_keypress;
docker ps

# https://docs.docker.com/userguide/usingdocker/
echo
echo -----------------------------------------------------------------
echo -n "# https://docs.docker.com/userguide/usingdocker/"
wait_for_keypress;

# Working with containers
echo
echo --------------------------------2.01: Working with containers---------------------------------

echo -n "$ sudo docker version"
wait_for_keypress;
docker version

# Get Docker command help
echo
echo --------------------------------2.02: Get Docker command help---------------------------------

echo -n "$ docker --help"
wait_for_keypress;
docker --help
echo -n "$ sudo docker attach --help"
wait_for_keypress;
docker attach --help

# Running a web application in Docker
echo
echo --------------------------------2.03: Running a web application in Docker---------------------------------

# Note the use of --name=nostalgic_morse which gives us a consistent name
# -P, --publish-all=false    Publish all exposed ports to random ports
echo -n '$ sudo docker run --name=nostalgic_morse -d -P training/webapp python app.py'
wait_for_keypress;
docker run --name=nostalgic_morse -d -P training/webapp python app.py

# Viewing our web application container
echo
echo --------------------------------2.04: Viewing our web application container---------------------------------

echo -n '$ sudo docker ps -l'
wait_for_keypress;
docker ps -l

# A network port shortcut
echo
echo --------------------------------2.05: A network port shortcut---------------------------------

echo -n "$ sudo docker port nostalgic_morse 5000"
wait_for_keypress;
docker port nostalgic_morse 5000

# 0.0.0.0, in this context, means "all IPv4 addresses on the local machine"
# Lets take a closer look:
echo -n "$ curl -s -i http://\$( sudo docker port nostalgic_morse 5000 )/"
wait_for_keypress;
curl -s -i http://$( docker port nostalgic_morse 5000 )/
echo

echo -n "$ sudo lsof -i | egrep 'docker|COMMAND'"
wait_for_keypress;
lsof -i | egrep 'docker|COMMAND'

# Viewing the web application’s logs
echo
echo --------------------------------2.06: Viewing the web application’s logs---------------------------------

echo "# hit CTRL-C to exit"
echo -n "$ sudo docker logs -f nostalgic_morse"
wait_for_keypress;
if [[ $INTERACTIVE == '1' ]];
then
    docker logs -f nostalgic_morse
    echo
fi

# Looking at our web application container’s processes
echo
echo --------------------------------2.07: Looking at our web application container’s processes---------------------------------

echo -n "$ sudo docker top nostalgic_morse"
wait_for_keypress;
docker top nostalgic_morse

# Inspecting our web application container
echo
echo --------------------------------2.08: Inspecting our web application container---------------------------------

echo -n "$ sudo docker inspect nostalgic_morse"
wait_for_keypress;
docker inspect nostalgic_morse

echo -n "$ sudo docker inspect -f '{{ .NetworkSettings.IPAddress }}' nostalgic_morse"
wait_for_keypress;
docker inspect -f '{{ .NetworkSettings.IPAddress }}' nostalgic_morse

# Stopping our web application container
echo
echo --------------------------------2.09: Stopping our web application container---------------------------------

echo -n "$ sudo docker stop nostalgic_morse"
wait_for_keypress;
docker stop nostalgic_morse

echo -n "$ sudo docker ps -l"
wait_for_keypress;
docker ps -l

# Restarting our web application container
echo
echo --------------------------------2.10: Restarting our web application container---------------------------------

echo -n "$ sudo docker start nostalgic_morse"
wait_for_keypress;
docker start nostalgic_morse

echo -n "$ sudo docker ps -l"
wait_for_keypress;
docker ps -l

# also 'sudo docker restart nostalgic_morse'

# Removing our web application container
echo
echo --------------------------------2.11: Removing our web application container---------------------------------

echo "# we expect this command to fail as the container is still running"
echo -n "$ sudo docker rm nostalgic_morse"
wait_for_keypress;
docker rm nostalgic_morse

echo -n "$ sudo docker stop nostalgic_morse"
wait_for_keypress;
docker stop nostalgic_morse

echo -n "$ sudo docker rm nostalgic_morse"
wait_for_keypress;
docker rm nostalgic_morse

# https://docs.docker.com/userguide/dockerimages/
echo
echo -----------------------------------------------------------------
echo -n "# https://docs.docker.com/userguide/dockerimages/"
wait_for_keypress;

# Listing images on the host
echo
echo --------------------------------3.01: Listing images on the host---------------------------------

echo -n '$ sudo docker images'
wait_for_keypress;
docker images

# Getting a new image
echo
echo --------------------------------3.02: Getting a new image---------------------------------

echo -n '$ sudo docker pull centos'
wait_for_keypress;
docker pull centos

echo "# type exit when you are done looking around"
echo -n '$ sudo docker run -t -i centos /bin/bash'
wait_for_keypress;
if [[ $INTERACTIVE == '1' ]];
then
    docker run -t -i centos /bin/bash
fi

# Finding images
echo
echo --------------------------------3.03: Finding images---------------------------------

echo -n '$ sudo docker search sinatra'
wait_for_keypress;
docker search sinatra

# Pulling our image
echo
echo --------------------------------3.04: Pulling our image---------------------------------

echo -n '$ sudo docker pull training/sinatra'
wait_for_keypress;
docker pull training/sinatra

echo "# type exit when you are done looking around"
echo -n '$ sudo docker run -t -i training/sinatra /bin/bash'
wait_for_keypress;
if [[ $INTERACTIVE == '1' ]];
then
    docker run -t -i training/sinatra /bin/bash
fi

# Creating our own images
echo
echo --------------------------------3.05: Creating our own images---------------------------------

echo "# type 'gem install json' inside your container"
echo "# type exit when you are done"
echo -n '$ sudo docker run -t -i training/sinatra /bin/bash'
wait_for_keypress;
if [[ $INTERACTIVE == '1' ]];
then
    docker run -t -i training/sinatra /bin/bash
else
    docker run training/sinatra gem install json
fi

CONTAINER_ID=$(docker ps -l -q)

echo -n "$ sudo docker commit -m 'Added json gem' -a \"$DOCKER_AUTHOR\" $CONTAINER_ID $OUR_USER/sinatra:v1"
wait_for_keypress;
docker commit -m "Added json gem" -a "$DOCKER_AUTHOR" $CONTAINER_ID $OUR_USER/sinatra:v1

echo -n '$ sudo docker images'
wait_for_keypress;
docker images

echo "# type exit when you are done"
echo -n "$ sudo docker run -t -i $OUR_USER/sinatra:v1 /bin/bash"
wait_for_keypress;
if [[ $INTERACTIVE == '1' ]];
then
    docker run -t -i $OUR_USER/sinatra:v1 /bin/bash
fi

# Building an image from a Dockerfile
echo
echo --------------------------------3.06: Building an image from a Dockerfile---------------------------------

DIRECTORY=$(pwd)/sinatra
DOCKERFILE=$DIRECTORY/Dockerfile
echo -n "$ mkdir $DIRECTORY"
wait_for_keypress;
if [ ! -d "$DIRECTORY" ]; then
    mkdir sinatra
fi
echo -n "$ cd $DIRECTORY"
wait_for_keypress;
cd $DIRECTORY
echo -n "$ touch $DOCKERFILE"
wait_for_keypress;

if [ -f "$DOCKERFILE" ];
then
    rm $DOCKERFILE
else
touch $DOCKERFILE

if [[ $INTERACTIVE == '1' ]];
then
    $EDITOR Dockerfile
else
    echo "# This is a comment
FROM ubuntu:14.04
MAINTAINER $DOCKER_AUTHOR <$DOCKER_EMAIL>
RUN apt-get update && apt-get install -y ruby ruby-dev
RUN gem install sinatra
" > Dockerfile
fi

echo -n "$ cat Dockerfile"
wait_for_keypress;
cat Dockerfile

echo -n "$ sudo docker build -t $OUR_USER/sinatra:v2 ."
wait_for_keypress;
docker build -t $OUR_USER/sinatra:v2 .

# Setting tags on an image
echo
echo --------------------------------3.07: Setting tags on an image---------------------------------

IMAGE_ID=$( docker images $OUR_USER/sinatra  | grep v2 | awk '{print $3}' )
echo -n "$ sudo docker tag $IMAGE_ID $OUR_USER/sinatra:devel"
wait_for_keypress;
docker tag $IMAGE_ID $OUR_USER/sinatra:devel

echo -n "$ sudo docker images $OUR_USER/sinatra"
wait_for_keypress;
docker images $OUR_USER/sinatra

# Image Digests
echo
echo --------------------------------3.08: Image Digests---------------------------------

echo -n "$ sudo docker images --digests | head"
wait_for_keypress;
docker images --digests | head

# Push an image to Docker Hub
echo
echo --------------------------------3.09: Push an image to Docker Hub---------------------------------
# TODO: use local registry here

# Remove an image from the host
# TODO: remove conteiners that are using this image first
echo --------------------------------3.10: Remove an image from the host---------------------------------

echo -n "$ sudo docker rmi training/sinatra"
wait_for_keypress;
docker rmi training/sinatra

# https://docs.docker.com/userguide/dockerlinks/
echo -n "# https://docs.docker.com/userguide/dockerlinks/"
wait_for_keypress;

# TODO: should we run any of the commands in:
# Connect using network port mapping

# The importance of naming
echo
echo --------------------------------4.01: The importance of naming---------------------------------

echo -n "$ sudo docker run -d -P --name web training/webapp python app.py"
wait_for_keypress;
docker run -d -P --name web training/webapp python app.py

echo -n "$ sudo docker ps -l"
wait_for_keypress;
docker ps -l

# Communication across links
echo
echo --------------------------------4.02: Communication across links---------------------------------

echo -n "$ sudo docker run -d --name db training/postgres"
wait_for_keypress;
docker run -d --name db training/postgres

echo -n "$ sudo docker rm -f web"
wait_for_keypress;
docker rm -f web

echo -n "$ sudo docker run -d -P --name web --link db:db training/webapp python app.py"
wait_for_keypress;
docker run -d -P --name web --link db:db training/webapp python app.py

echo -n "$ sudo docker inspect -f "{{ .HostConfig.Links }}" web"
wait_for_keypress;
docker inspect -f "{{ .HostConfig.Links }}" web

echo -n "$ sudo docker run --rm --name web2 --link db:db training/webapp env"
wait_for_keypress;
docker run --rm --name web2 --link db:db training/webapp env

# Updating the /etc/hosts file
echo
echo --------------------------------4.03: Updating the /etc/hosts file---------------------------------

echo "# type 'cat /etc/hosts'"
echo "# type 'apt-get install -yqq inetutils-ping'"
echo "# type 'ping webdb'"
echo "# type 'nc -v -z webdb 5432'"
echo "# type exit when you are done running these commands"
echo -n "$ sudo docker run -t -i --rm --link db:webdb training/webapp /bin/bash"
wait_for_keypress;
if [[ $INTERACTIVE == '1' ]];
then
    docker run -t -i --rm --link db:webdb training/webapp /bin/bash
else
    docker run --rm --link db:webdb training/webapp cat /etc/hosts
fi

echo -n "$ sudo docker restart db"
wait_for_keypress;
docker restart db

echo "# type 'cat /etc/hosts'"
echo "# type exit when you are done"
echo "$ sudo docker run -t -i --rm --link db:db training/webapp /bin/bash"
wait_for_keypress;
if [[ $INTERACTIVE == '1' ]];
then
    docker run -t -i --rm --link db:db training/webapp /bin/bash
else
    docker run --rm --link db:db training/webapp cat /etc/hosts
fi

# https://docs.docker.com/userguide/dockervolumes/
echo -n "# https://docs.docker.com/userguide/dockervolumes/"
wait_for_keypress;

# Adding a data volume
echo
echo --------------------------------5.01: Adding a data volume---------------------------------

docker rename web web1

echo -n "$ sudo docker run -d -P --name web -v /webapp training/webapp python app.py"
wait_for_keypress;
docker run -d -P --name web -v /webapp training/webapp python app.py

# Locating a volume
echo
echo --------------------------------5.02: Locating a volume---------------------------------

echo -n "$ sudo docker inspect web"
wait_for_keypress;
docker inspect web

# Mount a host directory as a data volume
echo
echo --------------------------------5.03: Mount a host directory as a data volume---------------------------------

docker rename web web2

echo -n "$ sudo docker run -d -P --name web -v /src/webapp:/opt/webapp training/webapp python app.py"
wait_for_keypress;
docker run -d -P --name web -v /src/webapp:/opt/webapp training/webapp python app.py

docker rename web web3

echo -n "$ sudo docker run -d -P --name web -v /src/webapp:/opt/webapp:ro training/webapp python app.py"
wait_for_keypress;
docker run -d -P --name web -v /src/webapp:/opt/webapp:ro training/webapp python app.py

# Mount a host file as a data volume
echo
echo --------------------------------5.04: Mount a host file as a data volume---------------------------------

# note correction
echo -n "$ sudo docker run --rm -it -v ~/.bash_history:/root/.bash_history ubuntu /bin/bash"
wait_for_keypress;
if [[ $INTERACTIVE == '1' ]];
then
    docker run --rm -it -v ~/.bash_history:/root/.bash_history ubuntu /bin/bash
fi

# Creating and mounting a data volume container
echo
echo --------------------------------5.05: Creating and mounting a data volume container---------------------------------

echo -n "$ sudo docker create -v /dbdata --name dbdata training/postgres /bin/true"
wait_for_keypress;
docker create -v /dbdata --name dbdata training/postgres /bin/true

echo -n "$ sudo docker run -d --volumes-from dbdata --name db1 training/postgres"
wait_for_keypress;
docker run -d --volumes-from dbdata --name db1 training/postgres

echo -n "$ sudo docker run -d --volumes-from dbdata --name db2 training/postgres"
wait_for_keypress;
docker run -d --volumes-from dbdata --name db2 training/postgres

echo -n "$ sudo docker run -d --name db3 --volumes-from db1 training/postgres"
wait_for_keypress;
docker run -d --name db3 --volumes-from db1 training/postgres

# Backup, restore, or migrate data volumes
echo
echo --------------------------------5.06: Backup, restore, or migrate data volumes---------------------------------

echo -n "$ sudo docker run --volumes-from dbdata -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata"
wait_for_keypress;
docker run --volumes-from dbdata -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata

echo -n "$ sudo docker run -v /dbdata --name dbdata2 ubuntu /bin/bash"
wait_for_keypress;
docker run -v /dbdata --name dbdata2 ubuntu /bin/bash
# why no shell here?

echo -n "$ sudo docker run --volumes-from dbdata2 -v $(pwd):/backup ubuntu cd /dbdata && tar xvf /backup/backup.tar"
wait_for_keypress;
docker run --volumes-from dbdata2 -v $(pwd):/backup ubuntu cd /dbdata && tar xvf /backup/backup.tar

# https://docs.docker.com/userguide/dockerrepos/
echo -n "# https://docs.docker.com/userguide/dockerrepos/"
wait_for_keypress;

# Searching for images
echo
echo --------------------------------6.01: Searching for images---------------------------------

echo -n "$ sudo docker search centos"
wait_for_keypress;
docker search centos
