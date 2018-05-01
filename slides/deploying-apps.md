## Deploying Applications


### Deploying Applications

* Inevitable goal of developing apps is to deploy them somewhere
* Typically some kind of hosting provider
   * Bare metal
   * Cloud Provider


### Immutable Architecture

* Approach to managing services where systems are replaced rather than changed in any way
* Entire stack rebuilt from scratch    
   * Servers
   * Network infrastructure
* Ensures reliable and predictable deployments by avoiding
   * Configuration drift   
   * Snowflake machines
* Relies on _on demand_ availability of servers


### Immutable Architecture
![immutable arch](img/immutable_infrastructure.gif "Immutable Architecture")


### Orchestration

* Hosting may consist of multiple machines
* Once infrastructure is in place, need way to manage containers
   * networking
   * volume mounts
   * linking between containers
   * general monitoring, healthchecks
   * Deploying new images
* This is where orchestration tools come in



### Container Orchestration

* Frameworks for container orchestration
   * Docker Swarm
   * Kubernetes
* Manage deployment/restarting containers across clusters
* Networking between containers (microservices)
* Scaling microservices
* Fault tolerance



### Kubernetes

* Container orchestrator
* Started by Google
* Inspired by Borg (Google's cluster management system)
* Open source project written in Go
* Cloud Native Computing Foundation
* Manage applications not machines



### Docker Swarm

* Standard since Docker 1.12 ![swarm](img/dockerswarm.png "Docker Swarm")<!-- .element: class="img-right" -->
* Manage containers across multiple machines
   * Scaling services
   * Healthchecks
   * Load balancing



### Docker Swarm

* Two types of machines or _nodes_
   * 1 or more _manager_ nodes
   * 0 or more _worker_ nodes
* Managers control global state of cluster
   * Raft Consensus Algorithm
   * If one manager fails, any other should take over
                      
                    


![swarm](img/voting-app-swarm.png "Docker Swarm")
