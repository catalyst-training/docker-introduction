## Deploying to Production


### Container Orchestration
* Primary means of deploying containerised applications to production <!-- .element: class="fragment" data-fragment-index="0" -->
* Provides tools for managing containers across a cluster <!-- .element: class="fragment" data-fragment-index="1" -->
   + networking
   + scaling
   + monitoring
* Ideal for deploying containerised applications in production <!-- .element: class="fragment" data-fragment-index="2" -->


### The concept

* You have a machine designated the <!-- .element: class="fragment" data-fragment-index="0" -->_master_ 
* You have a cluster of machines called <!-- .element: class="fragment" data-fragment-index="1" -->_nodes_ 

![Orchestration](img/container-orchestration.svg "Container Orchestration") <!-- .element: class="fragment" data-fragment-index="3" -->


### Masters and Nodes
* The <!-- .element: class="fragment" data-fragment-index="3" -->_master_  is reponsible for
   + scheduling containers to run across all <!-- .element: class="fragment" data-fragment-index="4" -->_nodes_
   + managing the network interaction between nodes <!-- .element: class="fragment" data-fragment-index="5" -->
   + monitoring container health <!-- .element: class="fragment" data-fragment-index="6" -->
   + periodically kill/respawn containers <!-- .element: class="fragment" data-fragment-index="7" -->
* The <!-- .element: class="fragment" data-fragment-index="8" -->_nodes_ or _workers_
   + Just run the containers



### Container Lifecycle 
* Containers are ephemeral
* The job of the _master_ is to make sure containers are healthy
* It will periodically kill and respawn a container
* This is very similar to _phoenix_ principle
![immutable arch](img/immutable_infrastructure.gif "Immutable Architecture")



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
