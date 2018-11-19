### Working with `docker-compose`


* `docker-compose` intended to be flexible tool for working in multiple
  envronments
   - feature development
   - simulate different platforms
   - dev, staging, uat, etc.
* There are many ways to customise `docker-compose` behaviour


#### `docker-compose` override file
* <!-- .element: class="fragment" data-fragment-index="0" -->`docker-compose up` automatically loads:
   - `docker-compose.yml`
   - `docker-compose.override.yml`
* <!-- .element: class="fragment" data-fragment-index="1" -->_override_ config takes precedence 
   - <code style="font-size:13pt;">docker-compose.yml </code><code style="color:red;font-size:13pt;"><</code><code style="font-size:13pt;">  docker-compose.override.yml</code>
* Let's try this out <!-- .element: class="fragment" data-fragment-index="2" -->


#### Using the `override` file
* In the <!-- .element: class="fragment" data-fragment-index="0" -->`example-voting-app` directory
* Create <!-- .element: class="fragment" data-fragment-index="1" -->`docker-compose.override.yml`:
   ```
version: "3"
services:
    vote:
      build: ./vote
      command: python app.py
      volumes:
      - ./vote:/app
      ports:
      - "5000:80"
      networks:
      - front-tier
      - back-tier
   ```
   <!-- .element: style="font-size:11pt;"  -->
* Restart the vote app <!-- .element: class="fragment" data-fragment-index="2" -->
   ```
   docker-compose up -d vote
   ```
* You should not see any change at this point <!-- .element: class="fragment" data-fragment-index="3" -->



##### Exercise: Use a different image
* Make <!-- .element: class="fragment" data-fragment-index="0" -->`docker-compose` use a specific image
* Make following changes<!-- .element: class="fragment" data-fragment-index="1" -->
   <pre style="font-size:12pt;"><code data-trim data-noescape>
        version: "3"
        <mark>volumes:
          vote_app:</mark>
        services:
          vote:
            build: ./vote
            <mark>image: heytrav/vote:v2</mark>
            command: python app.py
            volumes:
            <mark>- vote_app:/app</mark>
            ports:
            - "5000:80"
            networks:
            - front-tier
            - back-tier
   </code></pre>
* Restart the vote application <!-- .element: class="fragment" data-fragment-index="2" -->
   ```
   docker-compose up -d vote
   ```


##### Exercise: Use a different image
* Reload the [vote](http://localhost:5000) application
* Repeat this using image created by other course participants
* Note that you will need to pull the image 


#### Explicitly overriding files
* Often need to have configuration for specific environment <!-- .element: class="fragment" data-fragment-index="0" -->
* For example, say you need a specific image on staging environments <!-- .element: class="fragment" data-fragment-index="1" -->
   - `docker-compose.staging.yml`
   <pre><code data-trim data-noescape>
        services:
          vote:
            image: PROJECT/vote:<mark>1.2.3</mark>
          .
          .
   </code></pre>
* <!-- .element: class="fragment" data-fragment-index="2" -->Common pattern is to compose files 
   <pre><code style="font-size:12pt;" data-trim>
    docker-compose -f docker-compose.yml -f docker-compose.staging.yml up -d
   </code></pre>



#### _Override_ files and version control
* Never commit `docker-compose.override.yml` to your version control
   * Always add to `.gitignore`
   * General rule: always delete when you don't need it
* Files for explicit override are fine to add to version control
   * `docker-compose.staging.yml`
   * `docker-compose.feature-branch.yml`


#### Environment Variables in `docker-compose`
* Populate values in compose file <!-- .element: class="fragment" data-fragment-index="0" -->
   - in your shell
      ```
      export TAG=6
      ```
   - then somewherei in your compose file
      <pre><code data-noescape data-trim>
   db:
     image: "mysql:<mark>${TAG}</mark>"
   </code></pre>
* Pass variables into containers using <!-- .element: class="fragment" data-fragment-index="1" -->_environment_ section
   - Similar to `docker run -e DBNAME=mydb ...`
   <pre><code data-trim data-noescape>
     db:
       image: mysql:latest
     <mark>  environment:
         DBNAME: mydb</mark>
       </code></pre>

<!-- .element: class="stretch"  -->


#### Environment variables and `env_file`
* If you have a lot of specific application variables you can define them in a separate file
* <!-- .element: class="fragment" data-fragment-index="0" -->In an external file (eg. `db.env`)
   ```
   DBNAME=mydb
   DBADMIN=admin
   DBPASSWORD=changeMe!
   ```
* In your compose file <!-- .element: class="fragment" data-fragment-index="1" -->
   <pre><code data-trim data-noescape>
   db:
     image: mysql:latest
   <mark>  env_file:
     - db.env</mark>
    </code></pre>


##### Exercise: Pass environment variables
* Override vote display options using environment variables
   - Hint: see lines 8 & 9 in `vote/app.py`
* Modify <!-- .element: class="fragment" data-fragment-index="0" -->`docker-compose.override.yml` as follows
   <pre style="font-size:12pt;"><code data-noescape data-trim>
    command: python app.py
    <mark>environment:
      OPTION_A: North Island
      OPTION_B: South Island</mark>
    volumes:
   </code></pre>
* Restart the vote application <!-- .element: class="fragment" data-fragment-index="1" -->
   ```
   docker-compose up -d vote
   ```
* Bonus: try this with <!-- .element: class="fragment" data-fragment-index="2" -->`.env_file`

<!-- .element: class="stretch"  -->


#### Using a `.env` file
* File called <!-- .element: class="fragment" data-fragment-index="0" -->`.env` containing environment variables
   ```
   TAG=v2
   DBNAME=staging
   DBPASSWORD=changeMe!
   DBUSER=myuser
   ```
* Can be used to set default values for <!-- .element: class="fragment" data-fragment-index="1" -->_any_ variables referenced in the compose file
* Definitely should not add this to repository <!-- .element: class="fragment" data-fragment-index="2" -->
* Add it to <!-- .element: class="fragment" data-fragment-index="3" -->`.gitignore`


#### Environment variable precedence
* Priority of environment variables <!-- .element: class="fragment" data-fragment-index="2" -->
   - Compose file
      * `environment:`
      * `env_file:`
   - shell variables
   - `.env` file
   - Dockerfile
   - variable is undefined