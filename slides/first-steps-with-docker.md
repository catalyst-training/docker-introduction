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
<ul>
                      <li class="fragment" data-fragment-index="1">Docker
                          starts container using alpine image</li>
  <li class="fragment" data-fragment-index="2">
 The <em>alpine</em> image contains the <a
     href="https://www.aplinelinux.org/about/">Alpine OS</a>, a very minimal
 Linux distribution. 
 </li>                      <li class="fragment" data-fragment-index="3">
                            <code >[command]</code> argument is executed
                            inside container
                            
                        </li>
                      <li class="fragment" data-fragment-index="4">Exits immediately</li>
                      <li class="fragment" data-fragment-index="5">A docker container only runs as long as it has a process (eg. a shell terminal or program) to run</li>
 

                    </ul>
