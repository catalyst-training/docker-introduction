## Container Orchestration


### Container Orchestration
* Manage containers across a cluster
   + networking
   + volume
   + monitoring
* Ideal for deploying containerised applications in production 


### The concept

* You have a machine designated the <!-- .element: class="fragment" data-fragment-index="0" -->_master_ 
* You have a cluster of machines called <!-- .element: class="fragment" data-fragment-index="1" -->_nodes_ 
   + containers will only run on nodes <!-- .element: class="fragment" data-fragment-index="2" -->
* The <!-- .element: class="fragment" data-fragment-index="3" -->_master_ node 
   + schedules a certain number of containers to run across all <!-- .element: class="fragment" data-fragment-index="4" -->_nodes_
   + manages the network interaction between nodes <!-- .element: class="fragment" data-fragment-index="5" -->
   + monitors container health <!-- .element: class="fragment" data-fragment-index="6" -->
   + periodically kills/respawns  containers <!-- .element: class="fragment" data-fragment-index="7" -->



### Concept of Container Orchestration <!-- .slide: class="image-slide" -->
![Orchestration](img/container-orchestration.svg "Container Orchestration") 


### Immutable Architecture <!-- .slide: class="image-slide" -->
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
