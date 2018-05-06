## Kubernetes


### Kubernetes Facts
* Greek word for _helmsman_ or _pilot_
* Also origin of words like _cybernetics_ and _government_
* Inspired by _Borg_, Google's internal scheduling tool
* Play on Borg _cube_


### Kubernetes Concepts
* Host types
   + master
      - performs _scheduling_
      - monitoring/healthchecks
   + node (formerly _minion_)
      - runs containers


### Kubernetes Concepts: Pods & Services
* A _pod_ is the unit of work  ![pod and services](img/pod-diagram.svg "Pod and Services") <!-- .element: class="img-right" style="width:50%;" -->
   + Consist of ≥ 1 containers
      - Always _scheduled_ together
      - Have same IP
      - Communication via localhost
* Service
   + Exposes IP of Pod to
      - Other Pods
      - External ports (i.e. web, API ingress)


### Kubernetes Architecture <!-- .slide: class="image-slide" -->
![kubernetes interaction](img/kubernetes-user-interaction.svg "Kubernetes Architecture")



### Kubernetes Concepts: Management
* Label
   + Key/Value pairs used to group objects
      - replication controllers
      - services
* Label Selectors 
   + Select objects base on labels
   + Semantics:
      - `role = webserver` 
      - `app != foo`, 
      - `role in (webserver, backend)`



### Kubernetes Concepts: Management
* Replication Controller (RC)
   + Manage pods identified by a label
   + Ensure certain number running at any given time
* Namespaces
   + Virtual cluster
   + Isolate set of containers on same physical cluster



### Kubernetes Lables & Replication Controllers <!-- .slide: class="image-slide" -->
![label-selectors](img/label-selectors.svg "Label Selectors") 



### Control Architecture <!-- .slide: class="image-slide" -->
![admin interaction](img/kubernetes-admin-interaction.svg "Kubernetes Admin Control")


### Provisioning Our Cluster
* Steps needed:
   + Create host machines in the cloud
   + Set up networking
   + Install Kubernetes dependencies
      - kubectl
      - kubeadm
      - kubelet
   + Join nodes to master
   + Deploy Kubernetes spec files




### Kubernetes Configuration

* Replication Controllers
   + Define _Pods_
   + The _unit_ of work for Kubernetes
* Services
   + Define network interface to a pod
   + ingress ports
   + map to a replication controller



### Setting up the Voting Application
* Have a look in the `example-voting-app/k8s-specifications`



### Create Kubernetes Cluster

```
ansible-playbook -K -i cloud-hosts \
   create-cluster-hosts.yml kubeadm-install.yml
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

```bash
for i in `ls *.yaml`; \
     do kubectl apply -n vote -f $i; done
```
* This tells kubernetes to begin setting up containers
  + creates network endpoints
  + assigns Pods to replication controller


### Watch cluster
```
watch -t -n1 'echo Vote Pods \
   && kubectl get pods -n vote -o wide \
   && echo && echo vote Services \
   && kubectl get svc -n vote \
   && echo && echo Nodes \
   && kubectl get nodes -o wide'
```



### View Website
* Once all containers are running you can visit your website
