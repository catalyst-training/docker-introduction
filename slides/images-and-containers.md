## Images and Containers



#### Docker Images

* Images are the basis of containers
* An image is a <em>readonly</em> file system similar to tar archive
* _Distributable_ artefact of Docker



#### Types of Images
<dl>
<dt class="fragment" data-fragment-index="0">Official Base Image</dt> 
<dd class="fragment" data-fragment-index="0">Created by single authority (OS, packages):
<br>
        <ul  class="fragment" data-fragment-index="0"style="width:50%;">
            <li>ubuntu:18.04</li>
            <li>
                centos:7.3.1611
            </li>
            <li>
                postgres
            </li>

        </ul>
</dd>
<dt class="fragment" data-fragment-index="1">Base Image</dt> <dd class="fragment" data-fragment-index="1">Can be any image (official or otherwise) that is used to build a new image</dd>
<dt class="fragment" data-fragment-index="2">Child Images</dt> <dd class="fragment" data-fragment-index="2">Build on base images and add functionality (this is the type you'll build)</dd>
</dl>



#### Image Naming Semantics
* No upper-case letters  <!-- .element: class="fragment" data-fragment-index="0" -->
* Tag is optional. Implicitly <!-- .element: class="fragment" data-fragment-index="1" -->_:latest_ if not specified
   * <!-- .element: class="fragment" data-fragment-index="2" --><code>postgres<em style="color:green">:9.4</em></code>
   * <!-- .element: class="fragment" data-fragment-index="3" --><code>ubuntu == ubuntu<em style="color:green">:latest</em> == ubuntu:<em style="color:green">18.04</em></code>
* Tags often used to denote version <!-- .element: class="fragment" data-fragment-index="4" -->
* Convention with official base images <!-- .element: class="fragment" data-fragment-index="5" -->
   * `latest` tag usually points to a long term support (LTS) version
* Tags are just pointers, they can be moved if necessary <!-- .element: class="fragment" data-fragment-index="6" -->


#### Image Naming Semantics
* If pushing to a registry, need url and username <!-- .element: class="fragment" data-fragment-index="0" -->
* If registry not specified, docker.io is default: <!-- .element: class="fragment" data-fragment-index="1" -->
    *  <!-- .element: class="fragment" data-fragment-index="1" --><code><em style="color:green">docker.io</em>/<em style="color:red">username</em>/my-image</code> == <code><em style="color:red">username</em>/my-image</code> 
      * <!-- .element: class="fragment" data-fragment-index="2" --><code><em style="color:green">my.reg.com/</em>my-image:1.2.3</code>
* The fully qualified image name identifies an image <!-- .element: class="fragment" data-fragment-index="3" -->
   * gitlab.catalyst.net.nz:4567/&lt;group&gt;/&lt;project&gt;:tag
   * quay.io/&lt;username&gt;/image-name:tag


#### Images and Layering

* Images are a type of _layered_ file system
* Each image is a type of archive file (eg. tar archive) containing
   * Additional archive files
   * Meta information
* Any child image built by adding layers on top of a base
* Each successive layer is set of differences to preceding layer


#### Images and Layering

| Layer | Description |
|---   | --- |
| 4 | execute <code>myfile.sh</code> |
| 3 | make myfile.sh executable |
| 2 | copy myfile.sh |
| 1 | install libraries | 
| 0 | Base Ubuntu OS |

* A layer is an instruction that 
   * changes the filesystem
   * tells Docker what to do when run



#### Sharing Image Layers

* Images will share any common layers
* Applies to
   * Images pulled from Docker
   * Images you build yourself


#### Sharing Image Layers
<div class="fragment" data-fragment-index="0"
    style="width:50%;float:left;">
    <p>
    Two separate images
    </p>
    <img  src="img/compare-images.svg"/>
</div>

<div class="fragment" data-fragment-index="1"
    style="width:50%;float:left;">
    <p>
    Docker's view
    </p>
    <img   src="img/image-share-layers.svg"/>
</div>



## Containers


#### Namespaces

* Restrict visibility ![Namespaces](img/docker-namespaces.png "Docker Namespaces") <!-- .element: class="img-right" -->
* Processes inside a namespace should only see that namespace
* Namespaces:
   * pid
   * mnt
   * user
   * ipc


#### cgroups

* Restrict usage ![cgroups](img/cgroups.svg "Cgroups") <!-- .element: class="img-right" -->
* Highly flexible; fine tuned
* Cgroups:
   * cpu
   * memory
   * devices
   * pids


#### Combining the Two

A running container represents a combination of
layered file system,
namespace and sets of cgroups

![combined](img/namespace-cgroup-combined.svg "Combined namespaces and cgroups")



#### Container Layering

* Container creates its own read/write layer on top of image
* Multiple containers each have own read/write layer, but can share the actual image



#### Container Layering
![Layers](img/sharing-layers.jpg "Sharing Layers")



#### Create images, explore layers

|Docker command    |Description    |Syntax|
|---   |---|---  |
|  `diff` |  Inspect changes to files on a container's filesystem| <code>docker </code><code >diff</code> <code style="color:purple">[options]</code> <code style="color:red;font-style:italic">CONTAINERID</code><code style="color:blue;font-style:italic"></code>|
| `commit` |  Create a new image from a container's changes | <code>docker </code><code >commit</code> <code style="color:purple">[options]</code> <code style="color:red;font-style:italic">CONTAINER</code><code style="color:blue;font-style:italic"> [IMAGE[:TAG]]</code>|
|  `history` |  Show history of an image| <code>docker </code><code >history</code> <code style="color:purple">[options]</code> <code style="color:red;font-style:italic">image</code><code style="color:blue;font-style:italic">:tag</code>|



##### Exercise: Show layer with `diff` 
```
docker run -it ubuntu:18.04 /bin/bash
root@CONTAINERID:/$ apt-get update 
root@CONTAINERID:/$ exit
```
<!-- .element: class="fragment" data-fragment-index="0"-->
```
docker diff CONTAINERID
```
<!-- .element: class="fragment" data-fragment-index="1"-->
* By running the cache update, you have added files to container's filesystem <!-- .element: class="fragment" data-fragment-index="2" -->
* The files displayed in the diff exist in the container's <!-- .element: class="fragment" data-fragment-index="3" -->_read/write_ layer
* They are not part of the image <!-- .element: class="fragment" data-fragment-index="4" -->



##### Exercise: Create a layer

* Create a new <!-- .element: class="fragment" data-fragment-index="0" -->_layer_ on top of the _base image_
   ```
   docker commit CONTAINERID ubuntu:update
   13132d42da3cc40e8d8b4601a7e2f4dbf198e9d72e37e19ee1986c280ffcb97c
   ```
   <!-- .element: style="font-size:12pt;  -->
* Created an image by committing changes in a container <!-- .element: class="fragment" data-fragment-index="2" -->
* Now have two separate images <!-- .element: class="fragment" data-fragment-index="3" -->
* Share common layers; only difference is new layer on ubuntu:update <!-- .element: class="fragment" data-fragment-index="4" -->



#### View Image Layers
`docker history ` `<image>` <!-- .element: style="color:red;"  --> 

```
docker history ubuntu:update
```
<!-- .element: class="fragment" data-fragment-index="0"
style="font-size:10pt;" -->
* This is now a <!-- .element: class="fragment" data-fragment-index="1" -->_child image_
* Compare the two images using <!-- .element: class="fragment" data-fragment-index="2" -->`docker history`
   ```
   docker image ls
   docker history ubuntu:18.04
   docker history ubuntu:update
   ```
   <!-- .element: style="font-size:12pt;  -->



## Creating Docker Images


#### The _Dockerfile_

* A text file 
* Usually named <code>Dockerfile</code>
* Sequential instructions for building a Docker image
* General format:
   ```
   DIRECTIVE  something something something
   ```
* Each instruction creates a layer on the previous



#### Types of Dockerfile directives

* <!-- .element: class="fragment" data-fragment-index="0" -->Initialise building stage an set *base image*
   ``` Dockerfile
   FROM <base image>
   ```
* Instructions for building the image <!-- .element: class="fragment" data-fragment-index="1" -->
   ```dockerfile
   COPY . /app
   RUN make /app
   ```
* Control Docker behaviour when you type `docker run...`
  <!-- .element: class="fragment" data-fragment-index="3" -->
   ```dockerfile
   EXPOSE 5000
   VOLUME /var/www/data
   CMD ["python", "/app/app.py"]
   ```
    


## Common Dockerfile Instructions


#### FROM
<code>FROM </code><code style="color:red;">image</code><code style="color:blue;">:tag</code>
                    
* Define the base image for a new image
    * <code>FROM ubuntu:17.04</code>
    * <code>FROM debian # :latest implicit</code>
    * <code>FROM my-custom-image:1.2.3</code>
* Image can be
    * An official base image
    * Another image you have created



#### RUN
<code>RUN </code><code
    style="color:red;">command</code><code style="color:blue;"> arg1 arg2 ...</code>

* Execute shell commands for building an image
<pre><code>RUN apt-get update && apt-get install python3</code></pre>
<pre><code>RUN mkdir -p /usr/local/myapp && cd /usr/local/myapp</code></pre>
<pre><code>RUN make all</code></pre>
<pre><code>RUN curl https://domain.com/somebig.tar  \
          | tar -xv | /bin/sh</code></pre>


#### COPY

<code>COPY </code><code style="color:red;">src dest</code>

* Copy files from build directory into image
<pre><code>COPY package.json /usr/local/myapp</code></pre>
<pre><code>COPY . /usr/share/www</code></pre>


#### WORKDIR

<code>WORKDIR </code><code style="color:red;">path</code>
<pre><code>WORKDIR /usr/local/myapp</code></pre>
* Create a directory in the image
* Subsequent commands will run relative to this directory until
   + end of Dockerfile
   + next <code>WORKDIR</code> directive



#### CMD

* Provide defaults to executable
* or provide executable
* Two ways to execute a command:
   * shell form: 
      * <code>CMD </code><code style="color:red;">command</code><code style="color:blue;"> param1 param2 ...</code>
   * exec form: 
      * <code>CMD ["command", "param1", "param2"]</code>


##### Exercise: Write a basic Dockerfile
```
cd ~/docker-introduction/sample-code/first-docker-file && ls
```
* Write a <!-- .element: class="fragment" data-fragment-index="0" -->`Dockerfile`:
   * Named <!-- .element: class="fragment" data-fragment-index="1" -->`Dockerfile`
   * Based on alpine <!-- .element: class="fragment" data-fragment-index="2" -->
   * Set working directory to <!-- .element: class="fragment" data-fragment-index="3" --> <code style="color:blue;">/app</code>
   * Copy <!-- .element: class="fragment" data-fragment-index="4" --> `hello.sh` into working directory
   * make <!-- .element: class="fragment" data-fragment-index="5" -->`hello.sh` executable
   * tell docker to run <!-- .element: class="fragment" data-fragment-index="6" -->`hello.sh` on docker run
<pre class="fragment" data-fragment-index="7"><code data-trim data-noescape>
FROM alpine
WORKDIR /app
COPY hello.sh .
RUN chmod +x hello.sh
CMD ["./hello.sh"]
</code></pre>


#### `docker build`

<code style="font-size:14pt;">docker build </code><code style="font-size:14pt;color:purple">[options]</code> <code
    style="font-size:14pt;color:red;">image</code><code style="font-size:14pt;color:blue;">:[tag]</code>
<code
    style="font-size:14pt;color:red;">./path/to/Dockerfile</code>

|Options |Arguments |Description|
|--- |--- |---|
|<code>    --compress             </code>|         |       Compress the build context using gzip|
|<code>-c, --cpu-shares           </code>|  int             |CPU shares (relative weight)|
|<code>    --cpuset-cpus          </code>|  string         |CPUs in which to allow execution (0-3, 0,1)|
|<code>    --cpuset-mems          </code>|  string         |MEMs in which to allow execution (0-3, 0,1)|
|<code>    --disable-content-trust</code>|            |Skip image verification (default true)|
|<code>-f, --file string          </code>|            |Name of the Dockerfile (Default is 'PATH/Dockerfile')|
|<code>    --pull                 </code>|            |Always attempt to pull a newer version of the image|
|<code>-t, --tag             </code>| list           |Name and optionally a tag in the 'name:tag' format|



##### Exercise: Build an image using a Dockerfile

* Build a Docker image:
   * Use Dockerfile from earlier example
   * Name image YOURNAME/my-first-image

```
docker build -t YOURNAME/my-first-image .  
```
<!-- .element: class="fragment" data-fragment-index="0" -->

<asciinema-player autoplay="1" loop="loop"  font-size="medium" speed="1" class="fragment" data-fragment-index="1" theme="solarized-light" src="asciinema/docker-build.json" cols="174" rows="12"></asciinema-player> 



### More Dockerfile Instructions


#### ENTRYPOINT
* Configure container that runs as executable <!-- .element: class="fragment" data-fragment-index="0" -->
* <!-- .element: class="fragment" data-fragment-index="1" -->Create a simple Dockerfile:
   ```
   cd ~/docker-introduction/sample-code/entrypoint_cmd_examples
   gedit Dockerfile
   ```
   <pre><code data-trim  data-noescape>
   FROM alpine:latest
   <mark class="fragment" data-fragment-index="3">ENTRYPOINT ["echo", "Good", "morning,", "Dave"]</mark>
   </code></pre>
* <!-- .element: class="fragment" data-fragment-index="2" -->Build the image and run container
   ```
   docker build -t basic-docker-image .
   docker run basic-docker-image
   ```
* <!-- .element: class="fragment" data-fragment-index="3" -->Modify Dockerfile as follows and repeat preceding step



#### Combining ENTRYPOINT and CMD

* <!-- .element: class="fragment" data-fragment-index="0" -->Arguments following the image for `docker run image` overrides `CMD`
* <!-- .element: class="fragment" data-fragment-index="1" -->Use exec form of ENTRYPOINT and CMD together to set base command and default arguments


#### ENTRYPOINT & CMD
* Hypothetical application <!-- .element: class="fragment" data-fragment-index="0" -->
  ```dockerfile
  FROM ubuntu:latest
  ENTRYPOINT ["./base-script"]
  .
  CMD ["test"]
  ```
* By default this image will just pass <!-- .element: class="fragment" data-fragment-index="1" -->`test` as argument to `base-script` to run unit tests by default.
   ```
   docker run my-image
   ```


#### ENTRYPOINT & CMD
<pre class="fragment" data-fragment-index="0"><code data-trim data-noescape>
docker run my-image <mark>server</mark>
</code></pre>

* Passing argument at the end tells it to override CMD and execute with <!-- .element: class="fragment" data-fragment-index="1" --><code>server</code> to run server feature 


#### Exploring ENTRYPOINT & CMD
```
cd sample-code/entrypoint_cmd_examples 
```

* Compare Dockerfiles: <!-- .element: class="fragment" data-fragment-index="0" -->
   * Dockerfile.cmd_only
   * Dockerfile.cmd_and_entrypoint
* Build images: <!-- .element: class="fragment" data-fragment-index="1" -->
   ```
   docker build -t cmd_only -f Dockerfile.cmd_only .
   docker build -t cmd_and_entrypoint \
           -f Dockerfile.cmd_and_entrypoint .
   ```
* Run both the images with or without an additional argument to see what happens <!-- .element: class="fragment" data-fragment-index="2" -->



#### More Dockerfile instructions 
<dl>
    <dt>EXPOSE        </dt>      <dd>ports to expose when running</dd>
    <dt>VOLUME        </dt>      <dd>folders to expose when running</dd>
    <dt>ENV        </dt>      <dd>Set an environment
    variable</dd>
</dl>

See official reference [documentation](https://docs.docker.com/engine/reference/builder/)  for more
