## The Docker platform   
Docker enables you to separate your applications from your infrastructure, so you can deliver software quickly.   
Docker provides the ability to package and run an application in a loosely isolated environment called a container.  
Docker uses a **client-server model[^1]**. The Docker client talks to the Docker daemon, which creates and manage Docker objects, such as images, containers, networks, and volumes.   
The Docker client and daemon communicate using a REST API, over UNIX sockets or a network interface. Another Docker client is Docker Compose, that lets you work with applications consisting of a set of containers.   
Docker is written in the **Go programming language** and leverages the **Linux kernel namespaces and cgroups**.    
#### Docker architecture consist of :
- **The Docker daemon**: which creates and manage Docker objects.   
- **The Docker client**: communicates with the docker daemon e.g. docker and docker-compose   
- **Docker registries**: stores Docker images. Docker Hub is a public registry that anyone can use, and Docker is configured to look for images on Docker Hub by default.You can even run your own private registry.
#### Docker objects includes:   
- **Image** : custom filesystem with metadata (e.g. environment variables , default command to run)
- **Container** :  sandboxed process on an isolated filesystem
- **Volume**
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
- [docker get-started doc ](https://docs.docker.com/get-started/)s
- [redhat OCI doc](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction#container)

[^1]: The docker documents state "client-server architecture".
