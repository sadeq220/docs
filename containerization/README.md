## The Docker platform   
Docker enables you to separate your applications from your infrastructure, so you can deliver software quickly.   
Docker provides the ability to package and run an application in a loosely isolated environment called a container.
Use containers to prevent differences between OS libraries and environments.     
Docker uses a **client-server model[^1]**. The Docker client talks to the Docker daemon, which creates and manage Docker objects, such as images, containers, networks, and volumes.   
The Docker client and daemon communicate using a REST API, over UNIX sockets or a network interface. Another Docker client is Docker Compose, that lets you work with applications consisting of a set of containers.   
Docker is written in the **Go programming language** and leverages the **Linux kernel namespaces and cgroups**.    
#### Docker architecture consist of :
- **The Docker daemon**: which creates and manage Docker objects.   
- **The Docker client**: communicates with the docker daemon e.g. docker and docker-compose   
- **Docker registries(image registry, container registry)**: stores Docker images. Docker Hub is a public registry that anyone can use, and Docker is configured to look for images on Docker Hub by default.You can even run your own private registry.
#### Docker objects includes:   
- **Image** : custom filesystem with metadata (e.g. environment variables , default command to run)
  - series of filesystem layers with configuration file(c.i. aufs, overlay)[from k8s up and running book]
  - > The first thing to remember is that files that are removed by subsequent layers in the system
    > are actually still present in the images; they’re just inaccessible.
- **Container** :  sandboxed process on an isolated filesystem
- **Volume** : persistent data storage for containers
- **Network**   

### Container Engine
There are several competing Container Image formats (Docker, Appc, LXD), but the industry is moving forward with a standard governed under the Open Container Initiative - sometimes referred to simply as `Open Containers` or the `OCI`.      
There are several competing Container Engines including Docker, **Podman**, CRI-O, Railcar, RKT, LXC. These Container Engines take a Container Image and turn it into a Container (aka running processes). How this happens is governed by the scope of the OCI which includes a Container Runtime Specification and a Reference Runtime Implementation called RunC.    

>A container engine is a piece of software that accepts user requests, including command line options, pulls images, and from the end user's perspective runs the container.      
> There are many container engines, including docker, RKT, CRI-O, and LXD. Also, many cloud providers, Platforms as a Service (PaaS), and Container Platforms have their own built-in container engines which consume Docker or OCI compliant Container Images.      
> Having an industry standard Container Image Format allows interoperability between all of these different platforms.    
> Going one layer deeper, most container engines don't actually run the containers, they rely on an OCI compliant runtime like runc.

Docker Engine acts as a client-server application with: docker daemon , docker cli , APIs which specify interfaces that programs can use to talk to and instruct the Docker daemon.     
Podman is a container Engine that relies on OCI compliant Container Runtime (runc, crun, runv, etc) to interface with the operating system and create the running containers.   
Podman provides a command-line interface (CLI) similar to Docker but operates without a central daemon, making it daemonless. Each Podman command launches a container process directly, making it more lightweight and suitable for environments where a daemon is not desired.    

### Volumes
Volumes are the preferred mechanism for persisting data generated by and used by Docker containers.     
There are two types of volume that can be used:   
- bind mounts
  - a directory inside the host filesystem 
- container engine volume
  - a directory managed by the container engine(e.g. docker daemon, podman)

Volumes are easier to back up or migrate than bind mounts.     
I/O is faster in Volumes when compared to container's writable layer, because of  `Storage Driver`.     
**Storage Driver**:     
Docker uses storage drivers to store image layers, and to store data in the writable layer of a container.     
Storage drivers are optimized for *space efficiency*,       
but (depending on the storage driver) write speeds are lower than native file system performance,      
especially for storage drivers that use a copy-on-write filesystem.     
```shell
# to create a named volume
docker volume create mariaDB_volume
docker volume ls
```
To mount a volume into a container using CLI:    
```shell
docker run -v mariaDB_volume:/var/lib/mysql/ mariadb:latest 
```
To mount a volume into a container using compose file:
```compose.yaml
services: 
  db:
      image: mariadb:10.5
      container_name: zzip_usermanagement
      command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
      restart: always
      volumes:
        - db_data:/var/lib/mysql
      environment:
        - MYSQL_DATABASE=zzip
        - MYSQL_USER=zzip
        - MYSQL_ROOT_PASSWORD=pass
        - MYSQL_PASSWORD=pass
      ports:
        - "127.0.0.1:3306:3306"

volumes:
  db_data:
```
ports section refers to `port forwarding` configuration     
between virtual network and Host network and complies with `Host:Container` form.    

**Optimize Image Size**:    
1) Files that are removed by subsequent layers in the system are actually still present in the images; they’re just inaccessible.    
2) Every time you change a layer, it changes every layer that comes after it.    
3) Don't do the actual program compilation as part of the construction of the application container image.
   1) It leaves all of the unnecessary development tools lying inside image.
   2) To resolve this problem, Docker introduced `multistage builds`.


**Volume Backup**:
To back up a Volume with archive files, you can use a temp container with that volume mounted as well as a bind mount.    
```bash
$VOLUME="replace with the name of your volume"
# Backup:
docker run --rm -v "${VOLUME}:/data" -v "${PWD}:/backup-dir" ubuntu tar cvzf /backup-dir/backup.tar.gz /data
# Restore:
docker run --rm -v "${VOLUME}:/data" -v "${PWD}:/backup-dir" ubuntu bash -c "rm -rf /data/{*,.*}; cd /data && tar xvzf /backup-dir/backup.tar.gz --strip 1"
```
You can also use `restic` to back up docker volumes.     

> [!WARNING]
> To prevent inconsistent state while backup RDBMS volumes, first lock db
> for example to lock mariadb execute `FLUSH TABLES WITH READ LOCK`
> and to reopen the db execute `UNLOCK TABLES`

### Build with Docker   
To build images automatically use the `Dockerfile` text file.
You write the `Dockerfile` in a domain-specific language, called the Dockerfile syntax.   
Here is the format of the Dockerfile:
```text
# Comment
INSTRUCTION arguments
```
A Dockerfile must begin with a **FROM instruction**.   
The **FROM instruction** specifies the *Parent Image* ( or base image by "FROM scratch" ) from which you are building.   
The order of Dockerfile instructions matter. A Docker build consists of a series of ordered build instructions.   
Each instruction in a Dockerfile roughly translates to an **image layer**.
> When you run a build, the builder attempts to reuse layers from earlier builds. If a layer of an image is unchanged, then the builder picks it up from the build cache.   
> If a layer has changed since the last build, that layer, and all layers that follow, must be rebuilt.   

so it is better to place any dependency download instruction at the beginning of the Dockerfile .   

#### shell and exec form
The *RUN*, *CMD*, and *ENTRYPOINT* instructions all have two possible forms:      
- exec form: `INSTRUCTION ["executable","param1","param2"]`     
- shell form: `INSTRUCTION command param1 param2`    

shell form uses default shell which is `["/bin/sh", "-c"]` on Linux and `["cmd", "/S", "/C"]` on Windows.     
use *SHELL* instruction to override the default shell.     
```dockerfile
SHELL ["/bin/zsh", "-c"]
```
for example:         
```dockerfile
SHELL ["/bin/bash","-c"]
RUN dnf install java-11-openjdk
# above instructions are equivalent of following instruction
RUN ["/bin/bash","-c","dnf","install","java-11-openjdk"]
```
exec form uses json array format in dockerfile syntax.     
exec form pass all json array elements to exec() system call.     

use *CMD* or *ENTRYPOINT* instructions to specify container runtime process (initial process(pid=1) of container runtime).    
Best practice is:     
use the exec form of *ENTRYPOINT* to set fairly stable default commands and arguments and then     
use either form of *CMD* to set additional defaults that are more likely to be changed.     
  the reasons are:    
- Command line arguments to `docker run <image>` will be appended after all elements in an exec form *ENTRYPOINT*, and will override all elements specified using *CMD*.     
- The shell form of *ENTRYPOINT* prevents any *CMD* command line arguments from being used. and also command line arguments to `docker run <image>` will be ignored.    
- The shell form of *ENTRYPOINT* will start /bin/sh as PID=1 process which means `docker stop` will send SIGTERM to /bin/sh     
    - this scenario implies that `docker stop` will stop main process forcefully(SIGKILL) on timout and the main process will not exit cleanly.     
    - because  /bin/sh -c does not pass signals and main process will exit forcefully(SIGKILL), it won't have chance to store its states on exit.

If you need shell abilities(e.g. parameter expansion,command substitution), use *ENTRYPOINT* exec form with shell, for example:
```dockerfile
ENTRYPOINT ["/bin/sh","-c","java ${JAVA_OPTS} -jar /api-gateway.jar ${0} ${@}"]
```
#### docker build context
```shell
# Build an image from a Dockerfile in current working directory e.g.
# docker build --tag=ImageName:tag <A build’s context>
# this command will send the build context to the docker daemon.
docker build --tag=acme/my-final-image:23.1 .
```   
By default, the docker build command will look for a Dockerfile at the root of the build context. use `-f` to specify Dockerfile path.   
Before the docker CLI sends the context to the docker daemon, it looks for a file named `.dockerignore` in the root directory of the context. If this file exists, the CLI modifies the context to exclude files and directories that match patterns in it.   
```text
# comment
# .dockerignore file accepts ant pattern
.git
**/*.java
```

### References
- [docker overview doc](https://docs.docker.com/get-started/overview/)
- [docker get-started doc](https://docs.docker.com/get-started/)    
- [docker ENTRYPOINT doc](https://docs.docker.com/reference/dockerfile/#entrypoint)
- [docker storage driver](https://docs.docker.com/engine/storage/drivers/)
- [docker compose file sample](https://github.com/docker/awesome-compose/blob/master/nextcloud-redis-mariadb/compose.yaml)
- [docker volume backup](https://www.augmentedmind.de/2023/08/20/backup-docker-volumes/)
- [redhat OCI doc](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction#container)
- [kubernetes up and running book](https://www.amazon.co.uk/Kubernetes-Running-Dive-Future-Infrastructure/dp/1492046531)

[^1]: The docker documents state "client-server architecture".
