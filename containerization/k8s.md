## Kubernetes(K8S) orchestrator    
Kubernetes is an open source container orchestration engine for     
automating deployment, scaling, and management of containerized applications.     
The open source project is hosted by the Cloud Native Computing Foundation (CNCF).

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

## References
- [kubernetes](https://kubernetes.io/docs/home/)
- [kubernetes up and running book](https://www.oreilly.com/library/view/kubernetes-up-and/9781491935668/)