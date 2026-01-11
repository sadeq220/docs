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
K8S encourage developers to adhere to the principles of `immutable infrastructure`. In an immutable system, rather than a series of incremental updates     
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
The advantage of the *Infrastructure as code* is `easy rollbacking`.    

## Scaling Development Teams with Microservices
The ideal team size is the `two-pizza team`.   
> As noted in a variety of research, the ideal team size is the “two-pizza team,” or   
> roughly six to eight people. This group size often results in good knowledge sharing,   
> fast decision making, and a common sense of purpose. Larger teams tend to suffer   
> from issues of hierarchy, poor visibility, and infighting, which hinder agility and success.

there is a tension between the ideal team size for    
agility and the necessary team size for the product’s end goals.   
The common solution to this tension has been the development of decoupled,    
service-oriented teams that each build a single microservice.

## Why to use k8s    
k8s as container management engine and container orchestration API:
- easy scaling due to declarative configs and discovery service
- separation of concerns bwn machine operator and application operator by using API
- economic benefit(efficiency) by utilizing each machine resource
  - further increase in efficiency comes from the fact that a test env can be quickly and cheaply created in different namespace
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