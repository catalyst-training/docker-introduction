### Some Docker Compose Tricks


#### Flexibility
* Development environments need to be flexible
* Necessary to quickly change environments
   - feature development
   - simulate different platforms
   - dev, staging, uat, etc.
* There are many ways to customise `docker-compose` behaviour


#### `docker-compose` override file
* By default <!-- .element: class="fragment" data-fragment-index="0" -->`docker-compose` load certain files
   - `docker-compose.yml`
   - `docker-compose.override.yml`
* Increasing precedence <!-- .element: class="fragment" data-fragment-index="1" -->
* <!-- .element: class="fragment" data-fragment-index="2" -->`docker-compose.override.yml` will override
`docker-compose.yml`
* Let's try this out <!-- .element: class="fragment" data-fragment-index="3" -->



#### Overriding
* In the `example-voting-app` directory
* Create `docker-compose.override.yml`:
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
* Restart the vote app
   ```
   docker-compose up -d vote
   ```


#### Environment Variables in `docker-compose`
* Populate values in compose file <!-- .element: class="fragment" data-fragment-index="0" -->
   <pre><code data-noescape data-trim>
   db:
     image: "mysql:<mark>${TAG}</mark>"
   </code></pre>
* Pass variables into containers <!-- .element: class="fragment" data-fragment-index="1" -->
   <pre><code data-trim data-noescape>
   db:
     image: mysql:latest
     <mark>environment:
       DBNAME: mydb</mark>
     </code></pre>

<!-- .element: class="stretch"  -->




#### Environment variables and `env_file`
* If you have alot of specific application variables you can define them in a separate file
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





#### Environment Variables in `docker-compose`
```
vim vote/app.py
```
* Modify `docker-compose.yml` as follows
   <pre><code data-noescape data-trim>
  vote:
    build: ./vote
    command: python app.py
    <mark>environment:
      OPTION_A: North Island
      OPTION_B: South Island</mark>
    volumes:
   </code></pre>
* Restart the vote application
   ```
   docker-compose up -d vote
   ```

<!-- .element: class="stretch"  -->


#### Composing compose files



#### Overriding Stuff



#### Image or Build



#### Volumes



#### Networks
