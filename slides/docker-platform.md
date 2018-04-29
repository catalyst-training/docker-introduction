## Docker Platform


### What is Docker?
<dl>
<dt>High level</dt>
<dd>
An open-source platform for creating,
running, and distributing software <em>containers</em>
that bundle software applications with all of
their dependencies.
</dd>
<dt>Low level</dt>
<dd>
A command-line tool for programmatically defining the contents of a Linux container in code, which can then be versioned, reproduced, shared, and modified easily just as if it were the source code to a program
</dd>
</dl>


### Docker Popularity

* Linux containers are not new <!-- .element: class="fragment" data-fragment-index="0" -->
   * FreeBSD Jails
   * LXC containers
   * Solaris Zones
* Docker is doing for containers what Vagrant did for virtual machines <!-- .element: class="fragment" data-fragment-index="1" -->
   * Easy to create
   * Easy to distribute


### Docker Workflow
* Developer packages application and supporting components into image <!-- .element: class="fragment" data-fragment-index="0" -->![workflow](img/Diapositive1.png "Developer workflow")  <!-- .element: class="img-right" style="width:50%;" -->
* Developer/CI pushes image to private or public registry <!-- .element: class="fragment" data-fragment-index="1" -->
* The image becomes the unit for distributing and testing your application.
  <!-- .element: class="fragment" data-fragment-index="2" --> 


### Portability

* Docker is supported on most modern operating systems
   * Linux (RHEL, CentOS, Ubuntu LTS, etc.)
   * OSX 
   * Windows
* Lightweight Docker optimized Linux distributions (CoreOS, Project Atomic, RancherOS, etc.)
* Private clouds (OpenStack, Vmware)
* Public clouds (AWS, Azure, Rackspace, Google)
