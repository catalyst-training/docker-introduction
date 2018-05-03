## Kubernetes


### Kubernetes Facts
* Started by Google
* Inspired by Borg (Google's cluster management system)
* Open source project written in Go
* Cloud Native Computing Foundation
* Manage applications not machines


### Kubernetes Concepts
* Host types
   + master
      - performs _scheduling_
      - monitoring/healthchecks
   + node (formerly _minion_)
* Unit of work
   + Pod
      - one or more containers


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
