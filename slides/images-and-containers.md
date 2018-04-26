## Images and Containers



### Docker Images

* Images are the basis of containers
* An image is a <em>readonly</em> file system similar to tar archive
* _Distributable_ artefact of Docker



### Types of Images
<dl>
<dt>Official Base Image</dt> 
<dd>Created by single authority (OS, packages):
<br>
        <ul style="width:50%;">
            <li>ubuntu:16.04</li>
            <li>
                centos:7.3.1611
            </li>
            <li>
                postgres
            </li>

        </ul>
</dd>
<dt>Base Image</dt> <dd>Can be any image (official or otherwise) that is used to build a new image</dd>
<dt>Child Images</dt> <dd>Build on base images and add functionality (this is the type you'll build)</dd>
</dl>



### Image Naming Semantics

* No upper-case letters
* Tag is optional. Implicitly <em>:latest</em> if not specified

   * <code>postgres<em style="color:green">:9.4</em></code>
   * <code>ubuntu == ubuntu<em style="color:green">:latest</em> == ubuntu:<em style="color:green">16.04</em></code>
   * If pushing to a registry, need url and username
   * If registry not specified, docker.io is default:
      *  <code><em style="color:green">docker.io</em>/<em style="color:red">username</em>/my-image</code> == <code><em style="color:red">username</em>/my-image</code> 
      * <code><em style="color:green">my.reg.com/</em>my-image:1.2.3</code>
* GitLab registry accept several variants:
   * gitlab.catalyst.net.nz:4567/&lt;group&gt;/&lt;project&gt;:tag
   * gitlab.catalyst.net.nz:4567/&lt;group&gt;/&lt;project&gt;/optional-image-name:tag
   * gitlab.catalyst.net.nz:4567/&lt;group&gt;/&lt;project&gt;/optional-name/optional-image-name:tag






