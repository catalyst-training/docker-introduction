## First Steps with Docker


### Docker Version
```
docker --version
Docker version 17.12.0-ce, build c6d4123
```

* Version numbering scheme similar to Ubuntu versioning: `YY.MM.#`



### In-line Documentation

* Just typing <code style="color:red;">docker</code> returns list of commands
* Comprehensive online docs on <a href="https://docs.docker.com/edge/engine/reference/commandline/docker/">Docker website</a>

```
$ docker<ENTER>

Usage:  docker COMMAND

A self-sufficient runtime for containers

Options:
--config string      Location of client config files (default "/Users/travis/.docker")
-D, --debug              Enable debug mode
--help               Print usage
```


### Basic Client Usage

<code>docker</code> <code style="color:red">command</code> <code style="color:blue;font-style:italic">[options] [args]</code> 

* Calling any command with <!-- .element: class="fragment" data-fragment-index="0" --><code style="color:red;">--help</code> displays documentation


#### Exercise: View documentation for `docker run`
<pre class="fragment" data-fragment-index="0"><code data-trim>
$ docker run --help
Usage:  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

Run a command in a new container

Options:
      --add-host list                  Add a custom host-to-IP mapping (host:ip)
  -a, --attach list                    Attach to STDIN, STDOUT or STDERR
      --blkio-weight uint16            Block IO (relative weight), between 10 and 1000, or 0 to disable (default 0)
      --blkio-weight-device list       Block IO weight (relative device weight) (default [])
      .
      .  
</code></pre>


### Search for Images

<code>docker search </code><code style="color:blue;">[OPTIONS]</code><code style="color:red;"> TERM</code> 
<table class="fragment" data-fragment-index="0">
    <tr>
    <th>Option</th>
    <th>Argument</th>
    <th>Description </th>
    </tr>
<tr><td>-f, --filter     </td><td>filter </td><td>  Filter output based on conditions provided</td></tr>
<tr><td>    --format     </td><td>string </td><td>  Pretty-print search using a Go template</td></tr>
<tr><td>    --help       </td><td>       </td><td>   Print usage</td></tr>
<tr><td>    --limit      </td><td>int    </td><td>   Max number of search results (default 25)</td></tr>
<tr><td>    --no-trunc   </td><td>       </td><td>  Don't truncate output</td></tr>
</table>



### Pull an image from a registry

<code>docker pull </code><code style="color:blue;">[OPTIONS]</code><code style="color:red;"> NAME</code><code style="color:blue;">[:TAG]</code> 

<table class="fragment" data-fragment-index="0">
    <tr>
    <th>Option</th>
    <th>Argument</th>
    <th>Description </th>
    </tr>

<tr><td>-a, --all-tags              </td><td>  </td><td>Download all tagged images in the repository</td></tr>
<tr><td>    --disable-content-trust </td><td>  </td><td>Skip image verification (default true)</td></tr>
<tr><td>    --help                  </td><td>  </td><td>Print usage</td></tr>

</table>
<asciinema-player class="fragment" data-fragment-index="1" autoplay="0" loop="loop"  font-size="medium" speed="1"
theme="solarized-light" src="asciinema/docker-pull.json" cols="200" rows="10"></asciinema-player>


### Run a Docker Container
<code>docker</code> <code >run</code> <code style="color:purple">[options]</code> <code style="color:red;font-style:italic">image</code> <code style="color:blue;font-style:italic">[command]</code> 

* <!-- .element: class="fragment" data-fragment-index="0" --><code>docker run</code> requires an <code style="color:red">image</code> argument
<table class="fragment" data-fragment-index="1">
<tr>
<th>Option</th>
<th>Argument</th>
<th>Description </th>
</tr>
<tr><td>-i     </td><th>         </th>      <td>Keep STDIN open</td></tr>
<tr><td>-t     </td><th>         </th>      <td>Allocate a tty</td></tr>
<tr><td>--rm   </td><th>         </th>      <td>Automatically remove container on exit</td></tr>
<tr><td>-v     </td><th>  list   </th>      <td>Mount a volume</td></tr>
<tr><td>-p     </td><th>  list   </th>      <td>List of port mappings</td></tr>
<tr><td>-e, --env     </td><th>  list   </th>
<td>Set environment variables</td></tr>
<tr><td>-d, --detach     </td><th></th>      <td>Run
container in background and print container ID</td></tr>
<tr><td>--link </td><th>  list   </th>      <td>Add link to another container</td></tr>
<tr><td>--name </td><th>  string </th>      <td>Name for the container</td></tr>
</table>


### Run a Simple Container

```
docker run hello-world
```
<asciinema-player autoplay="1" loop="loop" font-size="medium" speed="1"
    theme="solarized-light" src="asciinema/asciicast-122666.json" cols="150" rows="10"></asciinema-player>

* The hello-world image was created by docker for instructional purposes. It just outputs a <!-- .element: class="fragment" data-fragment-index="0" -->_hello world_-like message and exits.


### Execute Command in a Container

<code>docker</code> <code >run</code> <code style="color:green;">image</code> <code style="color:blue;font-style:italic">[command]</code>
<pre class="fragment" data-fragment-index="0"><code data-trim>
$ docker run alpine ls
bin
dev
.
.
usr
var
$ 
</code></pre>

* Docker starts container using alpine image <!-- .element: class="fragment" data-fragment-index="0" -->
* The <!-- .element: class="fragment" data-fragment-index="1" -->_alpine_ image contains [Alpine OS](https://www.aplinelinux.org/about/), a very minimal Linux distribution.    
*  <!-- .element: class="fragment" data-fragment-index="2" -->`[command]` argument is executed inside container 
* Exits immediately <!-- .element: class="fragment" data-fragment-index="3" -->
* A docker container only runs as long as it has a process (eg. a shell terminal or program) to run <!-- .element: class="fragment" data-fragment-index="4" -->


#### Exercise: Start an _interactive_ shell

<code>docker</code> <code >run</code> <code style="color:red;">[options]</code> <code >alpine</code> <code>/bin/sh</code>

* Find <code>[options]</code> to make container run interactively
<pre class="fragment" data-fragment-index="0"><code data-trim>
docker run -it alpine /bin/sh
</code></pre>

<asciinema-player class="fragment" data-fragment-index="0" autoplay="1" loop="loop"  font-size="medium" speed="1"
    theme="solarized-light" src="asciinema/asciicast-119490.json" cols="174" rows="5"></asciinema-player>


### Running an interactive container
* Docker starts alpine image <!-- .element: class="fragment" data-fragment-index="0" -->
   * <!-- .element: class="fragment" data-fragment-index="1" -->`-i` interactively
   * <!-- .element: class="fragment" data-fragment-index="1" -->`-t` allocate a pseudo-TTY
* Runs shell command <!-- .element: class="fragment" data-fragment-index="2" -->
* Execute commands inside container <!-- .element: class="fragment" data-fragment-index="2" -->
* Exiting the shell stops the process and the container <!-- .element: class="fragment" data-fragment-index="3" -->
                    


### `docker ps`
* List currently running containers <!-- .element: class="fragment" data-fragment-index="0" -->
* <!-- .element: class="fragment" data-fragment-index="1" -->By default docker will assign a random name to each container (i.e. *adoring_edison*).
   <pre  class="fragment" data-fragment-index="2" style="width:100%"><code data-trim>
$ docker ps
CONTAINER ID  IMAGE                                ... NAMES
b3169acf49f8  alpine                               ... adoring_edison
02aa3e50580c  heytrav/docker-introduction-slides   ... docker-intro
</code></pre>
<table class="fragment" data-fragment-index="3">
     <tr>
       <th>Option                  </th>
       <th>Argument</th>
       <th>Description</th>
     </tr>

     <tr><td><code>-a, --all      </code></td><td>            </td><td> Show all containers (default shows just running)</td></tr>
     <tr><td><code>-f, --filter   </code></td><td> filter     </td><td>    Filter output based on conditions provided</td></tr>
     <tr><td><code>    --format   </code></td><td> string     </td><td>    Pretty-print containers using a Go template</td></tr>
     <tr><td><code>    --help     </code></td><td>            </td><td> Print usage</td></tr>
     <tr><td><code>    --no-trunc </code></td><td>            </td><td> Don't truncate output</td></tr>
   </table>


#### Exercise: Assign the name <em>myalpine</em> when running previous example container
* Hint: <code>docker run -it </code><code style="color:red;">&lt;option&gt;</code><code> alpine</code>
<pre class="fragment" style="width:100%;" data-fragment-index="0"><code data-trim>
docker run -it --name myalpine alpine /bin/sh
</code></pre>
<pre class="fragment" style="width:100%;" data-fragment-index="1"><code data-trim>
docker ps
CONTAINER ID        IMAGE                                ...   NAMES
db1faf244e7a        alpine                               ...   myalpine
02aa3e50580c        heytrav/docker-introduction-slides   ...   docker-intro
</code></pre>
* Exit the shell <!-- .element: class="fragment" data-fragment-index="2" -->
* Repeat using same name.  What happens? <!-- .element: class="fragment" data-fragment-index="3" -->
<asciinema-player  class="fragment" data-fragment-index="4" autoplay="1" loop="loop"  font-size="medium" speed="1"
    theme="solarized-light" src="asciinema/name-in-use-error.json" cols="200"
    rows="6"></asciinema-player>


### Removing containers
<!-- .element: class="fragment" data-fragment-index="0" --><code>docker</code> <code style="color:red;">rm</code> <code style="color:green;">name|containerID</code>
                    


#### Exercise: Remove old _myalpine_ container
<pre class="fragment" data-fragment-index="0"><code data-trim>
docker rm myalpine
</code></pre>
<asciinema-player  class="fragment" data-fragment-index="0" autoplay="1" loop="loop"  font-size="medium" speed="1"
    theme="solarized-light" src="asciinema/remove-container.json" cols="200" rows="12"></asciinema-player>

* <!-- .element: class="fragment" data-fragment-index="2" -->If you pass the <code style="color:red;">--rm</code> flag to <code>docker run</code>, containers will be cleaned up when
stopped.


#### Exercise: Run a website in a container
<pre><code data-trim>
docker run [OPTIONS] dockersamples/static-site
</code></pre>

* Find values for [OPTIONS]: <!-- .element: class="fragment" data-fragment-index="0" -->
   * <!-- .element: class="fragment" data-fragment-index="1" -->Give it the name: _static-site_
   * <!-- .element: class="fragment" data-fragment-index="2" -->Pass <code>AUTHOR="YOURNAME"</code> as environment variable
   * <!-- .element: class="fragment" data-fragment-index="3" -->Map port 8081 to 80 internally (hint <code>8081:80</code>)
   * Cleans up container on exit <!-- .element: class="fragment" data-fragment-index="4" -->


#### Run a website in a container
<asciinema-player autoplay="1" class="fragment" data-fragment-index="0" loop="loop"  font-size="medium" speed="1"
    theme="solarized-light" src="asciinema/static-site-v1.json" cols="120" rows="8"></asciinema-player>

* <!-- .element: class="fragment" data-fragment-index="1" -->`docker run` implicitly pulls image if not available 
* Try to exit using CTRL-C. What happens? <!-- .element: class="fragment" data-fragment-index="2" -->



### Stopping a running container
<code>docker</code> <code style="color:red;">stop</code> <code style="color:green;">name|containerID</code>



#### Exercise: Stop the _static-site_ container

* You actually have a couple options: <!-- .element: class="fragment" data-fragment-index="0" -->
   * use the name you gave to the container <!-- .element: class="fragment" data-fragment-index="1" -->
      ```
      $ docker stop static-site
      ```
   * <!-- .element: class="fragment" data-fragment-index="2" -->use the `CONTAINERID` from `docker ps` output (will depend on your environment)
      ```
      $ docker stop 25eff330a4e4
      ```


#### Exercise: Run a detached container

* Run static-site container like you did before, but add option to run in the background (i.e.  <em>detached</em> state).
   <pre class="fragment" data-fragment-index="0"><code data-trim>
   docker run --rm --name static-site -e AUTHOR="YOUR NAME" \
        -d -p 8081:80 dockersamples/static-site
   </code></pre>           

<asciinema-player  class="fragment" data-fragment-index="1" autoplay="1" loop="loop"  font-size="medium" speed="1"
    theme="solarized-light" src="asciinema/asciicast-122718.json" cols="120" rows="8"></asciinema-player>

Note: Have users stop (<code>docker stop static-site</code>) and start this container with the exact same line. Have them run again with the <code>--rm</code> flag


### View Container Logs
<code>docker</code> <color style="color:red;">logs</color> <code style="color:blue;">[options]</code> <code style="color:red;">CONTAINER</code>
<table>
   <tr>
     <th>Option</th>
     <th>Argument</th>
     <th>Description</th>
   </tr>

   <tr><td><code>    --details    </code></td><td>       </td> <td>      Show extra details provided to logs</td></tr>
   <tr><td><code>-f, --follow     </code></td><td>       </td> <td>      Follow log output</td></tr>
   <tr><td><code>    --help       </code></td><td>       </td> <td>      Print usage</td></tr>
   <tr><td><code>    --since      </code></td><td> string</td> <td>            Show logs since timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)</td></tr>
   <tr><td><code>    --tail       </code></td><td> string</td> <td>             Number of lines to show from the end of the logs (default "all")</td></tr>
   <tr><td><code>-t, --timestamps </code></td><td>       </td> <td>      Show timestamps</td></tr>
 </table>
See <a href="https://docs.docker.com/engine/reference/commandline/logs/">online documentation</a>
                      


#### Excercie: View container logs for _static-site_ container

 <asciinema-player class="fragment" data-fragment-index="0" autoplay="1" loop="1" font-size="medium" speed="1" theme="solarized-light" src="asciinema/asciicast-122552.json" cols="170" rows="14"></asciinema-player>

Go to <!-- .element: class="fragment" data-fragment-index="1" -->[localhost:8081](http://localhost:8081) and refresh a few times



#### Exercise: Check process list in _static-site_ container
<asciinema-player class="fragment" data-fragment-index="0"  autoplay="1" loop="1" font-size="medium"
   theme="solarized-light" speed="1" src="asciinema/asciicast-122554.json" cols="150" rows="13"></asciinema-player>



### List Local Images
```
docker image ls
```
<asciinema-player autoplay="1" loop="loop"  font-size="medium" speed="1"
    theme="solarized-light" src="asciinema/asciicast-119494.json" cols="174" rows="7"></asciinema-player>



### Docker Behind the Scenes

* User types docker commands
* Docker client contacts docker daemon
* Docker daemon checks if image exists
* Docker daemon downloads image from docker registry if it does not exist
* Docker daemon runs container using image
                      


### Docker Architecture
![architecture](img/architecture.svg "Docker Architecture")
