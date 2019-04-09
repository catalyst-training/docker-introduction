## Setup


### Fetch course resources

```
git clone https://github.com/catalyst-training/docker-introduction.git
```
<!-- .element: style="width:100%;" class="fragment" data-fragment-index="0" -->

```
cd ~/docker-introduction
```
<!-- .element: style="width:100%;" class="fragment" data-fragment-index="1" -->

* This folder contains: <!-- .element: class="fragment" data-fragment-index="2" -->
   * Slides for reveal.js presentation
   * docker-introduction.pdf
   * Ansible setup playbook
   * Sample code for exercises

<!-- .element: class="stretch"  -->



### Ansible

* Some of the features we will be exploring require setup. We'll use Ansible for that.
* Ansible is a Python-based tool set
* Useful for automation
   * server/cluster management 
   * package installation
   * code deploys
   * configuration management


### Ansible Setup
```
git clone https://github.com/catalyst/catalystcloud-ansible.git
```

<!-- .element: style="width:100%;" class="fragment" data-fragment-index="0" -->

```
cd ~/catalystcloud-ansible
./install-ansible.sh
. 
. <stuff happens>
.
source $CC_ANSIBLE_DIR/ansible-venv/bin/activate
```
<!-- .element: style="width:100%;" class="fragment" data-fragment-index="1" -->

* Installs Python virtualenv with latest Ansible libraries <!-- .element: class="fragment" data-fragment-index="2" -->
* This virtualenv will be used for tasks throughout the course <!-- .element: class="fragment" data-fragment-index="3" -->

<!-- .element: class="stretch"  -->


### Docker Setup

* Follow the instructions from the links below <!-- .element: class="fragment" data-fragment-index="0" -->
   * [Docker Community Edition](https://store.docker.com/search?offering=community&type=edition)
   * [docker-compose](https://docs.docker.com/compose/install/)
* You can use the Ansible playbook included in the course repo if you are using Ubuntu <!-- .element: class="fragment" data-fragment-index="1" -->

```
cd docker-introduction
ansible-galaxy -f -r ansible/requirements.yml
ansible-playbook -i ansible/hosts -K ansible/docker-install.yml 
```
<!-- .element: class="fragment" data-fragment-index="1"  -->



### Docker Setup
* This playbook installs:
   * latest Docker _Community Edition_
   * `docker-compose`
* You may need to log out and log in again


### Fetch and run slides
```
docker pull heytrav/docker-introduction-slides:latest
docker run --name docker-intro -d --rm \
        -p 8000:8000 heytrav/docker-introduction-slides
```
<asciinema-player autoplay="1" loop="loop"  font-size="medium" speed="1" theme="solarized-light" src="asciinema/asciicast-119477.json" cols="150" rows="15"></asciinema-player>
* Follow along with the <!-- .element: class="fragment" data-fragment-index="0" -->[course slides](http://localhost:8000)


### Pre-pull some containers
* A few of the lessons require large containers
* Run the `pre-pull-images` playbook to begin downloading them ahead of time
```
ansible-playbook -i ansible/hosts ansible/pre-pull-images.yml
```
