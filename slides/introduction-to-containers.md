## Introduction to Containers



### What is containerisation?

* A type of virtualization
* Differences from traditional VMs
   * Does not replicate entire OS, just bits needed for application
   * Run natively on host
* Key benefits:
   * More lightweight than VMs
   * Efficiency gains in storage, CPU
   * Portability

Note: Same application container can run on any system or cloud.



### Lightweight <!-- .slide: class="image-slide" --> 
<img src="img/docker.png" alt="">
<aside class="notes">
    <ul>
        <li>Virtual machines run guest operating systems (note OS layer)</li>
        <li>Resource intensive</li>
        <li>
            Resulting disk image and application state entanglement of
            <ul>
                <li>OS Settings</li>
                <li>System dependencies</li>
                <li>OS patches</li>
            </ul>
        </li>
    </ul>
</aside>
                  

### Benefits: Resources
<ul>
<li>Containers share a kernel</li>
<li>Use less CPU than VMs</li>
<li>Less storage. Container image only contains:
    <ul>
        <li>executable</li>
        <li>application dependencies</li>
    </ul>
</li>
</ul>


### Benefits: Decoupling

* Application stack not coupled to host machine ![imutable](img/immutable_infrastructure.gif "opt title") <!-- .element: class="img-right" -->
* Scale and upgrade services independently
* Treat services like cattle instead of pets 


### Benefits: Developer Workflow

* Easy to distribute
* Developers can wrap application with libs and dependencies as a single package 
* Easy to move code from development environments to production in easy and replicable fashion 

