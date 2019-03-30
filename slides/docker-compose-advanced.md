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
   docker-compose down -v 
   docker-compose up -d
   ```
* You should not see any change at this point <!-- .element: class="fragment" data-fragment-index="3" -->



##### Exercise: Use a different image
* Make <!-- .element: class="fragment" data-fragment-index="0" -->`docker-compose` use a specific image
* Edit <!-- .element: class="fragment" data-fragment-index="1" -->`docker-compose.override.yml`
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
   docker-compose down -v 
   docker-compose up -d
   ```


##### Exercise: Use a different image
* Reload the [vote](http://localhost:5000) application
* Repeat this using an image created by other course participants
* _Note_ you will need to pull the image 


#### Explicitly overriding files
* Often practical to have configuration for specific environments <!-- .element: class="fragment" data-fragment-index="0" -->
* <!-- .element: class="fragment" data-fragment-index="1" -->Use `-f` option to specify compose file instead of `docker-compose.yml`
* For example, say you need a specific image on staging environments <!-- .element: class="fragment" data-fragment-index="2" -->
   - `docker-compose-staging.yml`
   <pre style="font-size:12pt;"><code data-trim data-noescape>
        services:
          vote:
            image: PROJECT/vote:<mark>1.2.3</mark>
          .
          .
   </code></pre>
   <pre class="fragment" data-fragment-index="3" ><code style="font-size:12pt;" data-trim>
    docker-compose -f docker-compose-staging.yml up -d
   </code></pre>


#### Chaining compose files
* <!-- .element: class="fragment" data-fragment-index="0" -->Compose files can
  be chained together
* <!-- .element: class="fragment" data-fragment-index="1" -->Override specific service(s)
   - <!-- .element: class="fragment" data-fragment-index="1" -->`docker-compose.yml`
   <pre><code data-trim data-noescape>
        services:
          vote:
            build: ./vote
            .
          postgres:
            image: postgres:10
   </code></pre>
   - <!-- .element: class="fragment" data-fragment-index="2" -->`docker-compose-staging.yml`
   <pre><code data-trim data-noescape>
        services:
          vote: # just override vote service with image
            image: PROJECT/vote:<mark>1.2.3</mark>
            .
   </code></pre>
   <pre class="fragment" data-fragment-index="3" style="font-size:12pt;"><code data-trim data-noescape>
   docker-compose -f docker-compose.yml \
      -f docker-compose.staging.yml up -d
   </code></pre>



#### Tips for compose files
* Avoid adding `docker-compose.override.yml` to your version control
   * Add to `.gitignore`
   * General rule: always delete when you don't need it
* Files for explicit override are fine to add to version control
   * `docker-compose-staging.yml`
   * `docker-compose-ci.yml`


#### Environment Variables in `docker-compose`
* Populate values in compose file <!-- .element: class="fragment" data-fragment-index="0" -->
   - in your shell
      ```bash
      export TAG=6
      ```
   - then somewhere in your compose file
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
* Bonus: try this with <!-- .element: class="fragment" data-fragment-index="2" -->`env_file`

<!-- .element: class="stretch"  -->


#### Using a `.env` file
* <!-- .element: class="fragment" data-fragment-index="0" -->A `.env` file can
  be used to define global default variables
   ```
   TAG=v2
   DBNAME=staging
   DBPASSWORD=changeMe!
   DBUSER=myuser
   ```
* Can be used for <!-- .element: class="fragment" data-fragment-index="1" -->_any_ variables referenced in the compose file
* Definitely should not add this to repository <!-- .element: class="fragment" data-fragment-index="2" -->
* Add it to <!-- .element: class="fragment" data-fragment-index="3" -->`.gitignore`


#### Environment variable precedence
* Priority of environment variables (highest to lowest)<!-- .element: class="fragment" data-fragment-index="2" -->
   - Compose file
      * `environment:`
      * `env_file:`
   - shell variables
   - `.env` file
   - Dockerfile
   - variable is undefined



#### Mounting Volumes
* A <!-- .element: class="fragment" data-fragment-index="0" -->_volume_ refers to a directory or filesystem that is mounted inside a docker container
* On the command line you typically mount a directory into a container using the <!-- .element: class="fragment" data-fragment-index="1" -->`-v` option
  ```
  docker run --rm -d -v ./vote:/app my-app
  ```
* <!-- .element: class="fragment" data-fragment-index="2" -->In a compose file, using the `volume` attribute accomplishes the same thing
  ```
services:
   myapp:
      image: my-app
      volumes:
         - ./vote:/app
  ```


#### Named Volumes
* <!-- .element: class="fragment" data-fragment-index="0" -->An alternative is
  to create _named_ volumes
   <pre style="font-size:12pt;"><code data-trim data-noescape>
version: "3"
services:
  db:
    image: db
    volumes:
      - <mark>data-volume</mark>:/var/lib/db
  backup:
    image: backup-service
    volumes:
      - <mark>data-volume</mark>:/var/lib/backup/data
<mark>volumes:
    data-volume:</mark>
</code></pre>


#### Named volumes
* Easy to create; just declare in compose file
* Persist when `docker-compose` is stopped and restarted
* Can be retrieved and inspected using `docker volume` subcommand
   ```
   docker volume --help
   ```
