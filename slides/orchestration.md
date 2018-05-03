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

### Create Kubernetes Cluster

```
ansible-playbook -K -i cloud-hosts create-cluster-hosts.yml kubeadm-install.yml
```

### Upload Kubernetes Spec files

```
cd ~/example-voting-app
scp k8s-specifications/*.yaml trainigpc-master:~/

```
  

### Verify Kubernetes Cluster

```
ssh trainingpc-master
kubectl get nodes
NAME               STATUS    ROLES     AGE       VERSION
trainingpc-master   Ready     master    26m       v1.10.2
trainingpc-worker1  Ready     <none>    25m       v1.10.2
trainingpc-worker2  Ready     <none>    25m       v1.10.2
```


### Create Namespace
* Create a namespace for our application

```
kubectl create namespace vote
```


### Load Specification Files

```
for i in `ls *.yaml`; do kubectl apply -n vote -f $i; done
```

### Watch cluster

```
watch -t -n1 'echo Vote Pods && kubectl get pods -n vote -o wide && echo && echo vote Services && kubectl get svc -n vote && echo && echo Nodes && kubectl get nodes -o wide'
```


