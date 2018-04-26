## Dockerising Applications


### Creating Applications in Docker
* In this section we will:
   * Create a small web app based on Python Flask
   * Write a Dockerfile
   * Build an image
   * Run the image
   * Upload image to a Docker registry
                    


#### Step 1. Set up the the web page
```
cd ~/docker-introduction/sample-code/flask-app
```
   <dl style="font-size:14pt;">
   <dt>app.py</dt> <dd>A simple flask application for displaying cat pictures</dd>
   <dt>requirements.txt</dt> <dd>list of dependencies for flask</dd>
   <dt>templates/index.html</dt> <dd>A jinja2 template</dd>
   <dt>Dockerfile</dt><dd>Instructions for building a Docker image</dd>
   </dl>

                    


#### Our Dockerfile
```
FROM alpine:3.5

# Install python and pip
RUN apk add --update py2-pip

# install Python modules needed by the Python app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# copy files required for the app to run
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/

# tell the port number the container should expose
EXPOSE 5000

CMD ["python", "/usr/src/app/app.py"]
```



### Build the Docker Image
```
cd ~/docker-introduction/sample-code/flask-app 
docker build -t YOURNAME/myfirstapp .
```
<asciinema-player autoplay="1" loop="loop"  font-size="medium" speed="1" theme="solarized-light" src="asciinema/asciicast-119506.json" cols="174" rows="22"></asciinema-player>


### Run the Container
```
docker run -p 8888:5000 --rm --name myfirstapp YOURNAME/myfirstapp
```
<asciinema-player autoplay="1" loop="loop"  font-size="medium" speed="1" theme="solarized-light" src="asciinema/asciicast-119510.json" cols="174" rows="11"></asciinema-player>
...Now open [your test webapp](http://localhost:8888)


### Login to Docker Registry
```
docker login <registry url>
```
<asciinema-player autoplay="1" loop="loop"  font-size="medium" speed="1" theme="solarized-light" src="asciinema/asciicast-120558.json" cols="138" rows="11"></asciinema-player>
* If registry not specified, logs into <a href="https://hub.docker.com">hub.docker.com</a>
* Can log in to multiple registries



### Push Image to Registry
```
docker push YOURNAME/myfirstapp
```
<asciinema-player autoplay="1" loop="loop"  font-size="medium" speed="1" theme="solarized-light" src="asciinema/asciicast-119547.json" cols="174" rows="12"></asciinema-player>


### Summary

* Wrote a small web application
* Used Dockerfile to create an image
* Pushed image to upstream registry

