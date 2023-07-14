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
### Footnotes
[^1]: The docker documents state "client-server architecture".
### References
- [docker overview doc](https://docs.docker.com/get-started/overview/)
- [docker get-started doc ](https://docs.docker.com/get-started/)