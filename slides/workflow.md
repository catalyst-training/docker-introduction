## Docker Development Workflow


####  Docker Deployment Pipeline
* In a nutshell <!-- .element: class="fragment" data-fragment-index="0" -->
   - test code
   - create image
   - distribute image
   - deploy somewhere
* Numerous ways to construct Docker deployment pipeline <!-- .element: class="fragment" data-fragment-index="1" -->
   - on premise
   - the webs


#### Source Control Management
* Developer pushes code ![Docker development workflow](img/development-ci-workflow-step1.svg "Docker workflow") <!-- .element: class="img-right" -->


#### Run unit tests

* Push to SCM fires webhook  ![Docker development workflow](img/development-ci-workflow-step2.svg "Docker workflow") <!-- .element: class="img-right" -->
* CI runs unit tests <!-- .element: class="fragment" data-fragment-index="0" -->
   - Jenkins
   - Travis-CI
   - GitLab



#### Build and ship images
* Perform  basic image build  ![Docker development workflow](img/development-ci-workflow-step3.svg "Docker workflow") <!-- .element: class="img-right" -->
   - `docker build `...
   - `docker push `...
* Push to registry <!-- .element: class="fragment" data-fragment-index="0" -->
   - [Docker Hub](https://hub.docker.com)
   - [Quay](https://quay.io)
   - Private Docker registry
* For example <!-- .element: class="fragment" data-fragment-index="2" -->:
   - [Repo for these slides](https://github.com/catalyst-training/docker-introductin)
   - [Docker registry](https://hub.docker.com/r/heytrav/docker-introduction-slides/builds/)


#### Deploy Container Workload
* Orchestration frameworks ![Docker development workflow](img/development-ci-workflow.svg "Docker workflow") <!-- .element: class="img-right" width="50%" height="50%" -->
   - Docker Swarm
   - Kubernetes
* Vendor solutions
   - AWS ECS
   - Azure Containers
