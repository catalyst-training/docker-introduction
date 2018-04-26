## How Docker Works


### Components of Docker

* Images
   * The _build_ component
   * Distributable _artefact_
* Containers
   * The _run_ component
* Registries
   * The _distribution_ component


### Components of Docker

![docker components](http://alandargan.com/wp-content/uploads/2014/11/Docker2.png "Components of Docker")


### Docker Registries

<div style="float:left;width:50%">
    <ul>
    <li>Public repositories for docker images
        <ul>
        <li><a href="https://hub.docker.com">Docker Hub</a></li>
        <li><a href="https://quay.io">Quay.io</a></li>
        <li>GitLab ships with docker registry</li>
        </ul>
    </li>
    <li>
        Create your own private registry
        <a href="https://github.com/docker/distribution">docker/distribution</a>
    </li>
    </ul>
</div>
<div style="float:left;width:50%">
    <img src="img/docker-hub.png" />
</div>


### Underlying Technology
<dl>
                            <dt>Go</dt><dd>Implementation language developed by Google</dd>
                            <dt>Namespaces</dt><dd>Provide isolated workspace, or <em>container</em></dd>
                            <dt>cgroups</dt><dd>limit application to specific set of resources </dd>
                            <dt>UnionFS</dt><dd>building blocks for containers </dd>
                            <dt>Container format</dt><dd> Combined namespaces,
                            cgroups and UnionFS</dd>
                        </dl>
