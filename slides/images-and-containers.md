## Images and Containers



### Docker Images

* Images are the basis of containers
* An image is a <em>readonly</em> file system similar to tar archive
* _Distributable_ artefact of Docker



### Types of Images
<dl>
<dt>Official Base Image</dt> 
<dd>Created by single authority (OS, packages):
<br>
        <ul style="width:50%;">
            <li>ubuntu:16.04</li>
            <li>
                centos:7.3.1611
            </li>
            <li>
                postgres
            </li>

        </ul>
</dd>
<dt>Base Image</dt> <dd>Can be any image (official or otherwise) that is used to build a new image</dd>
<dt>Child Images</dt> <dd>Build on base images and add functionality (this is the type you'll build)</dd>
</dl>



### Image Naming Semantics
* No upper-case letters  <!-- .element: class="fragment" data-fragment-index="0" -->
* Tag is optional. Implicitly <!-- .element: class="fragment" data-fragment-index="1" --><em>:latest</em> if not specified
   * <!-- .element: class="fragment" data-fragment-index="2" --><code>postgres<em style="color:green">:9.4</em></code>
   * <!-- .element: class="fragment" data-fragment-index="3" --><code>ubuntu == ubuntu<em style="color:green">:latest</em> == ubuntu:<em style="color:green">16.04</em></code>
* If pushing to a registry, need url and username <!-- .element: class="fragment" data-fragment-index="4" -->


### Image Naming Semantics
* If registry not specified, docker.io is default: <!-- .element: class="fragment" data-fragment-index="0" -->
    *  <!-- .element: class="fragment" data-fragment-index="1" --><code><em style="color:green">docker.io</em>/<em style="color:red">username</em>/my-image</code> == <code><em style="color:red">username</em>/my-image</code> 
      * <!-- .element: class="fragment" data-fragment-index="2" --><code><em style="color:green">my.reg.com/</em>my-image:1.2.3</code>
* GitLab registry accept several variants: <!-- .element: class="fragment" data-fragment-index="3" -->
   * gitlab.catalyst.net.nz:4567/&lt;group&gt;/&lt;project&gt;:tag
   * gitlab.catalyst.net.nz:4567/&lt;group&gt;/&lt;project&gt;/optional-image-name:tag
   * gitlab.catalyst.net.nz:4567/&lt;group&gt;/&lt;project&gt;/optional-name/optional-image-name:tag


### Images and Layering

* Images are a type of _layered_ file system
* Each image is a type of archive file (eg. tar archive) containing
   * Additional archive files
   * Meta information
* Any child image built by adding layers on top of a base
* Each successive layer is set of differences to preceding layer


### Images and Layering

| Layer | Description |
|---   | --- |
| 4 | execute <code>myfile.sh</code> |
| 3 | make myfile.sh executable |
| 2 | copy myfile.sh |
| 1 | install libraries | 
| 0 | Base Ubuntu OS |

* A layer is an instruction that 
   * change filesystem
   * tells Docker what to do when run



### Sharing Image Layers

* Images will share any common layers
* Applies to
   * Images pulled from Docker
   * Images you build yourself


### Sharing Image Layers
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
    Reality: common layers shared
    </p>
    <img   src="img/image-share-layers.svg"/>
</div>



### View Image Layers
<code>docker history </code><code style="color:red;">&lt;image&gt;</code>
<pre  class="fragment" data-fragment-index="0"
                    style="width:100%"><code data-trim>
docker history heytrav/docker-introduction-slides
                    
IMAGE          CREATED       CREATED BY             SIZE                COMMENT
e72084f25e08   2 months ago  /bin/sh -c #(nop)      0B                  
&lt;missing&gt;      2 months ago  /bin/sh -c #(no        0B                  
   .
   .
&lt;missing&gt;      9 months ago  /bin/sh -c #(n         0B                  
&lt;missing&gt;      9 months ago  /bin/sh -c #(n         3.97MB</code></pre>


## Containers


### Namespaces

* Restrict visibility ![Namespaces](img/docker-namespaces.png "Docker Namespaces") <!-- .element: class="img-right" -->
* Processes inside a namespace should only see that namespace
* Namespaces:
   * pid
   * mnt
   * user
   * ipc


### cgroups

* Restrict usage ![cgroups](img/cgroups.svg "Cgroups") <!-- .element: class="img-right" -->
* Highly flexible; fine tuned
* Cgroups:
   * cpu
   * memory
   * devices
   * pids


### Combining the Two

A running container represents a combination of
layered file system,
namespace and sets of cgroups

![combined](img/namespace-cgroup-combined.svg "Combined namespaces and cgroups")



### Container Layering

* Container creates its own read/write layer on top of image
* Multiple containers each have own read/write layer, but can share the actual image



### Container Layering
![Layers](img/sharing-layers.jpg "Sharing Layers")



### Create images, explore layers

|Docker command    |Description    |Syntax|
|---   |---|---  |
|  `diff` |  Inspect changes to files on a container's filesystem| <code>docker </code><code >diff</code> <code style="color:purple">[options]</code> <code style="color:red;font-style:italic">CONTAINERID</code><code style="color:blue;font-style:italic"></code>|
| `commit` |  Create a new image from a container's changes | <code>docker </code><code >commit</code> <code style="color:purple">[options]</code> <code style="color:red;font-style:italic">CONTAINER</code><code style="color:blue;font-style:italic"> [IMAGE[:TAG]]</code>|
|  `history` |  Show history of an image| <code>docker </code><code >history</code> <code style="color:purple">[options]</code> <code style="color:red;font-style:italic">image</code><code style="color:blue;font-style:italic">:tag</code>|



#### Exercise: Explore Image Layers
<pre class="fragment" data-fragment-index="0"><code data-trim>
docker run -it ubuntu:16.04 /bin/bash
root@CONTAINERID:/$ apt-get update 
root@CONTAINERID:/$ exit
docker ps -a
docker diff CONTAINERID
</code></pre>
<pre class="fragment" data-fragment-index="1"><code data-trim>
docker commit CONTAINERID ubuntu:update
13132d42da3cc40e8d8b4601a7e2f4dbf198e9d72e37e19ee1986c280ffcb97c
</code></pre>
<pre class="fragment" data-fragment-index="2"><code data-trim>
docker image ls
docker history ubuntu:16.04
docker history ubuntu:update
</code></pre>



### Explore Image Layers
* Created an image by committing changes in a container <!-- .element: class="fragment" data-fragment-index="3" -->
* Now have two separate images <!-- .element: class="fragment" data-fragment-index="4" -->
* Share common layers; only difference is new layer on ubuntu:update <!-- .element: class="fragment" data-fragment-index="5" -->



## Creating Docker Images



### Introducing the _Dockerfile_

* A text file 
* Usually named <code>Dockerfile</code>
* Sequential instructions for building a Docker image
* Each instruction creates a layer on the previous


### Structure of a Dockerfile

* Start by telling Docker which base image to use <!-- .element: class="fragment" data-fragment-index="0" -->
   ``` Dockerfile
   FROM <base image>
   ```
* A number of commands telling docker how to build image <!-- .element: class="fragment" data-fragment-index="1" -->
   ```dockerfile
   COPY . /app
   RUN make /app
   ```
* Optionally tell Docker what command to run when the container is started
  <!-- .element: class="fragment" data-fragment-index="3" -->
   ```dockerfile
   CMD ["python", "/app/app.py"]
   ```
    


## Common Dockerfile Instructions


### FROM
<code>FROM </code><code style="color:red;">image</code><code style="color:blue;">:tag</code>
                    
* Define the base image for a new image
    * <code>FROM ubuntu:17.04</code>
    * <code>FROM debian # :latest implicit</code>
    * <code>FROM my-custom-image:1.2.3</code>
* Image can be
    * An official base image
    * Another image you have created


### RUN
<code>RUN </code><code
    style="color:red;">command</code><code style="color:blue;"> arg1 arg2 ...</code>

* Execute shell commands for building an image
<pre><code>RUN apt-get update && apt-get install python3</code></pre>
<pre><code>RUN mkdir -p /usr/local/myapp && cd /usr/local/myapp</code></pre>
<pre><code>RUN make all</code></pre>
<pre><code>RUN curl https://domain.com/somebig.tar | tar -xv | /bin/sh</code></pre>


### COPY

<code>COPY </code><code style="color:red;">src dest</code>

* Copy files from build directory into image
<pre><code>COPY package.json /usr/local/myapp</code></pre>
<pre><code>COPY . /usr/share/www</code></pre>


### WORKDIR

<code>WORKDIR </code><code style="color:red;">path</code>
* Create a directory in the image
* Container will run relative to this directory
<pre><code>WORKDIR /usr/local/myapp</code></pre>


### CMD

* Provide defaults to executable
* or provide executable
* Two ways to execute a command:
   * shell form: 
      * <code>CMD </code><code style="color:red;">command</code><code style="color:blue;"> param1 param2 ...</code>
   * exec form: 
      * <code>CMD ["command", "param1", "param2"]</code>


#### Exercise: Write a basic Dockerfile
```
cd ~/docker-introduction/sample-code/first-docker-file && ls
```
* Write a <code>Dockerfile</code>:
   * Named <code>Dockerfile</code>
   * Based on alpine
   * Set working directory to <code style="color:blue;">/app</code>
   * Copy hello.sh into working directory
   * make hello.sh executable
   * tell docker to run hello.sh on docker run
<pre class="fragment" data-fragment-index="0"><code data-trim>
FROM alpine
WORKDIR /app
COPY hello.sh .
RUN chmod +x hello.sh
CMD ["./hello.sh"]
</code></pre>



### `docker build`

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



#### Exercise: Build an image using a Dockerfile

* Build a Docker image:
   * Use Dockerfile from earlier example
   * Name image YOURNAME/my-first-image
<pre class="fragment" data-fragment-index="0"><code data-trim>
docker build -t YOURNAME/my-first-image .  
</code></pre>

<asciinema-player autoplay="1" loop="loop"  font-size="medium" speed="1" class="fragment" data-fragment-index="1" theme="solarized-light" src="asciinema/docker-build.json" cols="174" rows="12"></asciinema-player> 



## More Dockerfile Instructions



### ENTRYPOINT
* Docker images need not be executable by default <!-- .element: class="fragment" data-fragment-index="0" -->
* ENTRYPOINT configures executable behaviour of container <!-- .element: class="fragment" data-fragment-index="1" -->
* <!-- .element: class="fragment" data-fragment-index="2" -->_shell_ and _exec_ forms just like <code>CMD</code>
<pre class="fragment" data-fragment-index="3"><code data-trim>
cd ~/docker-introduction/sample-code/entrypoint_cmd_examples
$ docker build -t not-executable -f Dockerfile.notexecutable .
$ docker run not-executable # does nothing
</code></pre>
<pre class="fragment" data-fragment-index="4"><code data-trim>
docker build -t executable -f Dockerfile.executable .
$ docker run executable
</code></pre>





