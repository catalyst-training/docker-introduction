## Kubernetes


### Kubernetes Facts

* Greek word for _helmsman_ or _pilot_
* Also origin of words like _cybernetics_ and _government_
* Inspired by _Borg_, Google's internal scheduling tool
* Play on _Borg cube_
* [Source](https://news.ycombinator.com/item?id=9653797)


### Kubernetes Concepts
* Host types
   + master
      - performs _scheduling_
      - monitoring/healthchecks
   + node (formerly _minion_)
      - runs containers


### Pods and Replication Controllers
* A _pod_ is the unit of work 
   + Consist of ≥ 1 containers ![pod and services](img/pod-diagram.svg "Pod and Services") <!-- .element: class="img-right" style="width:50%;" -->
      - Always _scheduled_ together
      - Have same IP
      - Communication via localhost


### Services
* Exposes IP of Pod to ![kubernetes interaction](img/kubernetes-user-interaction.svg "Kubernetes Architecture") <!-- .element: class="img-right" style="width:50%;" -->
    + Other Pods
    + External ports (i.e. web, API ingress)



### Replication Controllers

* Replication Controller (RC)
   + Manage pods identified by a label
   + Ensure certain number running at any given time


### Labels & Selectors
* Label is a key: value pair used to group objects
    - replication controllers for scheduling pods
    - services 
* Label Selectors 
   + Select objects base on labels
   + Semantics:
      - `role = webserver` 
      - `app != foo`, 
      - `role in (webserver, backend)`



### Kubernetes Labels & Replication Controllers <!-- .slide: class="image-slide" -->
![label-selectors](img/label-selectors.svg "Label Selectors") 



### Kubernetes Concepts: Management
* Namespaces
   + Virtual cluster
   + Isolate set of containers on same physical cluster



### Defining a Replication Controller
* Specification deployment file
* Attributes define <!-- .element: class="fragment" data-fragment-index="0" -->
   + How many instances to run at start<!-- .element: class="fragment" data-fragment-index="1" -->
   + Label selectors <!-- .element: class="fragment" data-fragment-index="1" -->
   + Images/containers in pod <!-- .element: class="fragment" data-fragment-index="2" -->
   + Volumes mounted in pod <!-- .element: class="fragment" data-fragment-index="3" -->

<!-- .element: style="width:50%;float:left;"  -->

<pre  style="width:40%;float:left;font-size:10pt;" ><code data-trim data-noescape>
<span class="fragment" data-fragment-index="0">apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: redis</span>
<span class="fragment" data-fragment-index="1">spec:
  <span class="fragment" data-fragment-index="1"><mark>replicas: 1</mark></span>
  template:
    metadata:
      labels:
        <mark>app: redis</mark></span>
    <span class="fragment" data-fragment-index="2">spec:
      containers:
      - <mark>image: redis:alpine</mark>
        name: redis
        volumeMounts:
        - mountPath: /data
          name: redis-data</span>
      <span class="fragment" data-fragment-index="3">volumes:
      - name: redis-data
        emptyDir: {}</span> 
        </code></pre>



### Defining a Service
* Service spec defines
  + Type <!-- .element: class="fragment" data-fragment-index="0" -->
     - <!-- .element: class="fragment" data-fragment-index="1" -->`NodePort | ClusterIP`
  + Ports & protocol <!-- .element: class="fragment" data-fragment-index="2" -->
  + Map to Replication Controller (Pod) <!-- .element: class="fragment" data-fragment-index="3" -->

<!-- .element: style="width:50%;float:left;"  -->

<pre style="width:40%;float:left;"><code data-trim data-noescape>
apiVersion: v1
kind: Service
metadata:
  name: redis
spec:
  <span class="fragment" data-fragment-index="1"><mark>type: ClusterIP</mark></span>
  <span class="fragment" data-fragment-index="2">ports:
  - port: 6379
    targetPort: 6379</span>
  <span class="fragment" data-fragment-index="3">selector:
    <mark>app: redis</mark></span></code></pre>



### Controlling Kubernetes
* Control plane of Kubernetes is a REST API ![admin interaction](img/kubernetes-admin-interaction.svg "Kubernetes Admin Control") <!-- .element: class="img-right" style="width:60%;"  -->
* Admin cluster using `kubectl` command line client


### Demo: Set up Voting Application in Kubernetes


### Setup
* Steps needed:
   + Create host machines in the cloud
   + Set up networking
   + Install Kubernetes dependencies
      - kubectl
      - kubeadm
      - kubelet
   + Join nodes to master
   + Deploy Kubernetes spec files



### Setting up the Voting Application
* Have a look in the `example-voting-app/k8s-specifications`



### Create Kubernetes Cluster

```
cd ~/docker-introduction
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


###  Experimenting with Kubernetes
* Drain node
* Rolling upgrade



### Clean up

```
ansible-playbook ansible/remove-cluster-hosts.yml -K
```
