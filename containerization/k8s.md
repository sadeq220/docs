## Kubernetes(K8S) orchestrator    
Kubernetes is an open source container orchestration engine for     
automating deployment, scaling, and management of containerized applications.     
The open source project is hosted by the Cloud Native Computing Foundation (CNCF).     

> Form K8s docs:
> The technical definition of orchestration is execution of a defined workflow: first do A, then B, then C.


K8S features:
- immutable infrastructure
  - once an artifact is created in the system it does not change via user modifications
- Declarative Configuration
  - declaration of the desired state of the system
- Self-Healing Systems
  - continuously takes actions to ensure that the current state
    matches the desired state.
- Scaling
  - replica and load balancing 

K8S facilitates both `declarative configuration` and automation, and provides `reliable, scalable distributed systems`.    
K8S encourage principles of `immutable infrastructure`. In an immutable system, rather than a series of incremental updates     
and changes, an entirely new, complete image is built.    
series of incremental updates example:    
```shell
dnf install bash-completion
vim /etc/random/config/file
timedatectl set-timezone Asia/Tehran
```

## Declarative Configuration
Everything in Kubernetes is a `declarative configuration` object that represents the desired state of the system.    
declarative configuration is an alternative to imperative configuration,      
where the state of the world is defined by the execution of a series of instructions rather than      
a declaration of the desired state of the world.    

The idea of storing declarative configuration in source control     
is often referred to as `infrastructure as code`.    

## Install and use K8S
There are a few options to use K8S:    
- Cloud provider SAS(e.g. Amazon EKS)
- development minikube

The official Kubernetes client is kubectl: a command-line tool for interacting with the Kubernetes API.     
The first thing you can do is check the version of the cluster that you are running:
```shell
$ kubectl version
```
## concepts 
Definition of some concepts:    
- namespace
  - to organize objects in the cluster.
- pod
- service
- deployment

## kube-system namespace
Many of the components that make up the Kubernetes cluster are actually deployed using Kubernetes itself.     
They reside in `kube-system` namespace.     
For example some pods:    
- kube-proxy
  - is a reverse proxy to route traffic to load-balanced services
  - must be on every K8S node
- DNS server  
  - provides naming and discovery for the services that are defined in the cluster.    

## References
- [kubernetes](https://kubernetes.io/docs/home/)
- [kubernetes up and running book](https://www.oreilly.com/library/view/kubernetes-up-and/9781491935668/)