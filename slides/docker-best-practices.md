## Designing Containerised Applications


#### Designing Containerised Applications
* Containerised component(s) should be agnostic to other services/components <!-- .element: class="fragment" data-fragment-index="0" -->
* Eg. application component may interact with <!-- .element: class="fragment" data-fragment-index="1" -->![agnostic](img/components-agnostic.svg "Agnostic Components") <!-- .element: class="img-right" -->
   * Containerised database in development  <!-- .element: class="fragment" data-fragment-index="2" -->
   * Cloud provider in production  <!-- .element: class="fragment" data-fragment-index="3" -->



#### Designing Containerised Applications
* Containerised application should <!-- .element: class="fragment" data-fragment-index="0" -->_smallest executable unit_
  * Have a single application <!-- .element: class="fragment" data-fragment-index="1" -->
  * Single executable runner <!-- .element: class="fragment" data-fragment-index="2" -->
  * Single process per container <!-- .element: class="fragment" data-fragment-index="3" -->
  * Single component of your application <!-- .element: class="fragment" data-fragment-index="4" -->
* No stored <!-- .element: class="fragment" data-fragment-index="5" -->_state_



#### Developing Applications
* Applications can consist of many components <!-- .element: class="fragment" data-fragment-index="0" -->  ![basic cluster](img/prod-application.svg "Simple Application") <!-- .element: class="img-right" style="width:30%;" -->
   * Web server (nginx, apache)
   * Database (sql, nosql)
   * Message Queue 
   * Your application
* <!-- .element: class="fragment" data-fragment-index="1" -->Typically spread across cluster of machines 



#### Development vs Production

* Ideal scenario: Development environment identical to production <!-- .element: class="fragment" data-fragment-index="0" -->
* In practice this is often difficult to achieve  <!-- .element: class="fragment" data-fragment-index="1" -->
   * Limited CPU of dev machines <!-- .element: class="fragment" data-fragment-index="2" -->![dev-env](img/dev-prod-deploy.svg "Dev environment") <!-- .element: class="img-right fragment" style="width:40%;" data-fragment-index="4" -->
   * Cost of machines <!-- .element: class="fragment" data-fragment-index="3" -->
   * Compromise is to develop everything in single VM <!-- .element: class="fragment" data-fragment-index="4" --> 


#### Pitfalls of Single VM Development
* Single VM development creates blindspot <!-- .element: class="fragment" data-fragment-index="0" -->
* Developers can make false assumptions about <!-- .element: class="fragment" data-fragment-index="1" -->
   * Which config files on which machines <!-- .element: class="fragment" data-fragment-index="2" -->
   * Which dependency libraries present on machines <!-- .element: class="fragment" data-fragment-index="3" -->
* Difficult to scale individual services <!-- .element: class="fragment" data-fragment-index="4" -->
* Applications components often tightly coupled <!-- .element: class="fragment" data-fragment-index="5" -->
* Can lead to unpredictable behaviour when application is deployed to production <!-- .element: class="fragment" data-fragment-index="6" -->


#### Containers to the rescue
* Containers can make this easier <!-- .element: class="fragment" data-fragment-index="0" -->
* Container serves as the  <!-- .element: class="fragment" data-fragment-index="1" -->_unit_ equivalent of microservice
* Deployable artefact (i.e. <!-- .element: class="fragment" data-fragment-index="2" -->_image_)
* Can be versioned <!-- .element: class="fragment" data-fragment-index="3" -->
* Layered filesystem <!-- .element: class="fragment" data-fragment-index="4" -->
   + Deploying updates equivalent of deploying _just what was changed_
Note: containers mitigate some of the above issues



#### Containerise Application Components
* Each component is self-contained <!-- .element: class="fragment" data-fragment-index="0" -->![containerised-dev](img/containerised-services.svg "Containerised deploy") <!-- .element: class="img-right" style="width:40%;" -->
   * dependencies <!-- .element: class="fragment" data-fragment-index="1" -->
   * configuration <!-- .element: class="fragment" data-fragment-index="2" -->
* Easier to scale <!-- .element: class="fragment" data-fragment-index="3" -->
* Brings us closer to production environment <!-- .element: class="fragment" data-fragment-index="4" -->
* It is possible to use exact same setup in dev and production
  <!-- .element: class="fragment" data-fragment-index="5" -->



#### Docker Developer Workflow
* In the following sections we'll explore ways of making development
  environment similar/identical to production <!-- .element: class="fragment" data-fragment-index="0" -->
* Development <!-- .element: class="fragment" data-fragment-index="1" -->
   * docker-compose as a tool for managing complex microservice applications in <!-- .element: class="fragment" data-fragment-index="2" -->
    development
* Production <!-- .element: class="fragment" data-fragment-index="3" -->
   * Orchestration platforms for deploying container workloads in production
     <!-- .element: class="fragment" data-fragment-index="4" -->
     environments
* Connecting the two with CI/CD workflows <!-- .element: class="fragment" data-fragment-index="5" -->
