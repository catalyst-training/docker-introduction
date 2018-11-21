## Docker Development Workflow


####  Docker Deployment Pipeline
* In a nutshell <!-- .element: class="fragment" data-fragment-index="0" -->
   - commit change
   - run (and pass) unit tests
   - create image
   - distribute image
   - deploy somewhere
* Numerous ways to construct Docker deployment pipeline <!-- .element: class="fragment" data-fragment-index="1" -->
   - on premise
   - the webs


#### Source Control Management (SCM)
* Developer commits change ![Docker development workflow](img/development-ci-workflow-step1.svg "Docker workflow") <!-- .element: class="img-right" -->
* Pushes change to centralised repository



#### Run unit tests

* Push to central repository fires webhook  ![Docker development workflow](img/development-ci-workflow-step2.svg "Docker workflow") <!-- .element: class="img-right" -->
* CI runs unit tests <!-- .element: class="fragment" data-fragment-index="0" -->
   - Jenkins
   - Travis-CI
   - GitLab



#### Build and ship images
* Build image artefact ![Docker development workflow](img/development-ci-workflow-step3.svg "Docker workflow") <!-- .element: class="img-right" -->
   - `docker build `...
* Push to registry <!-- .element: class="fragment" data-fragment-index="0" -->
   - `docker push `...
   - <!-- .element: class="fragment" data-fragment-index="1" -->[Docker Hub](https://hub.docker.com)
   - <!-- .element: class="fragment" data-fragment-index="2" -->[Quay](https://quay.io)
   - <!-- .element: class="fragment" data-fragment-index="3" -->[Local Registry](https://docs.docker.com/registry/deploying)
* For example <!-- .element: class="fragment" data-fragment-index="4" -->:
   - [Repo for these slides](https://github.com/catalyst-training/docker-introductin)
   - [Docker registry](https://hub.docker.com/r/heytrav/docker-introduction-slides/builds/)


#### Deploying containers
* Deploy containerised microservices ![Docker development workflow](img/development-ci-workflow.svg "Docker workflow") <!-- .element: class="img-right" width="50%" height="50%" -->
* Orchestration frameworks <!-- .element: class="fragment" data-fragment-index="0" -->
   - Docker Swarm
   - Kubernetes
* Vendor specific solutions <!-- .element: class="fragment" data-fragment-index="1" -->
   - AWS ECS
   - Azure Containers


#### Overlapping Functionality
* Some solutions or tools may have multiple roles <!-- .element: class="fragment" data-fragment-index="0" -->
   - SCM: Gitlab, Bitbucket
   - CI: Jenkins, GitLab
   - Build/ship images: Jenkins, Gitlab, DockerHub
   - Registry: DockerHub, Quay, GitLab
* All-in-one (or almost-all-in-one) solutions <!-- .element: class="fragment" data-fragment-index="1" -->
