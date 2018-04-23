## Setup


### Fetch course resources

<pre class="fragment" data-fragment-index="0"><code data-trim data-noescape>
$ git clone \
    https://github.com/catalyst-training/docker-introduction.git
$ cd docker-introduction
</code></pre>

<pre class="fragment" data-fragment-index="0"><code data-trim>
$ cd ~/docker-introduction
$ ls
</code></pre>

<ul style="width:80%;">
<li class="fragment" data-fragment-index="1">Slides for Reveal.js presentation</li>
<li class="fragment" data-fragment-index="2">docker-introduction.pdf</li>
<li class="fragment"
data-fragment-index="3">Ansible setup playbook</li>
<li class="fragment" data-fragment-index="4">Sample code for some exercises</li>
</ul>



### Ansible
<ul>
    <li>
    Some of the features we will be exploring require
    setup. We'll use ansible for that.
    </li>
    <li>Python based tool set</li>
    <li>Automate devops tasks
        <ul>
            <li>server/cluster management </li>
            <li>installing packages</li>
            <li>deploying code </li>
            <li>Configuration management</li>
        </ul>
</ul>



## Setup Ansible
<pre class="fragment" data-fragment-index="0"><code data-trim>
git clone \
     https://github.com/catalyst/catalystcloud-ansible.git
</code></pre>

<pre class="fragment" data-fragment-index="1"><code data-trim>
cd ~/catalystcloud-ansible
./install-ansible.sh
. 
. &lt;stuff happens&gt;
.
$ source $CC_ANSIBLE_DIR/ansible-venv/bin/activate
</code></pre>
<ul style="width:80%;" class="fragment" data-fragment-index="2">
    <li>Installs python virtualenv with latest ansible
    libraries</li>
    <li>We'll be using this virtualenv for tasks
        throughout the course.</li>
</ul>



## Setup Docker
<ul style="width:80%;">
<li class="fragment" data-fragment-index="0">
Follow instructions on website for installing
<ul>
<li><a href="https://store.docker.com/search?offering=community&type=edition">Docker Community Edition</a></li>
<li><a href="https://docs.docker.com/compose/install/">docker-compose</a></li>
</ul>
</li>
<li class="fragment" data-fragment-index="1">If
you are using Ubuntu, use the ansible playbook included in course repo</li>
</ul>
<pre class="fragment" data-fragment-index="1"><code data-trim>
$ cd docker-introduction
$ ansible-playbook -K ansible/docker-install.yml \
        -e ansible_python_interpreter=/usr/bin/python
</code></pre>




## Setup Docker
<ul style="width:80%;">
<li class="fragment" >
This playbook installs:
<ul>
<li class="fragment"
>latest Docker <em>Community Edition</em></li>
<li class="fragment"
><code>docker-compose</code></li>
<li class="fragment"
>You might need to logout and login again
</li>
</ul>
</li>
</ul>



## Fetch and run slides
<pre><code data-trim>
$ docker run --name docker-intro -d --rm \
    -p 8000:8000 heytrav/docker-introduction-slides
</code></pre>
    <asciinema-player autoplay="1" loop="loop"  font-size="medium" speed="1" theme="solarized-light" src="asciinema/asciicast-119477.json" cols="150" rows="15"></asciinema-player>
    <p>
    Follow along with course slides: <a href="http://localhost:8000">http://localhost:8000</a>
    </p>



