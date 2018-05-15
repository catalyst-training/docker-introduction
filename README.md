# Introduction to Docker

[Course Outline](slides/course-outline.md)

> **Note:** The canonical location for this repository is
> https://github.com/catalyst-training/docker-introduction

Presentation and tutorials for an introduction to docker.  This repository includes:

* A Reveal.js presentation with instructional material for an introduction to
  docker
* Sample code for training exercises

The presentation is available as a docker image that can be pulled directly
from Docker Hub.

```
docker run -d --rm --name docker-intro -p 8000:8000 \
    heytrav/docker-introduction-slides
```


The slides can be viewed locally by navigating to
[http://localhost:8000](http://localhost:8000) in your browser.

The image is built automatically whenever changes are pushed to the github
repo. The course material will change as we adapt the material to keep up with
new features in Docker and the ecosystem as a whole.
