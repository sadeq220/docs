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

### References
- [docker overview doc](https://docs.docker.com/get-started/overview/)
- [docker get-started doc ](https://docs.docker.com/get-started/)

[^1]: The docker documents state "client-server architecture".
