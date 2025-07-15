## Kubernetes(K8S) orchestrator    
Kubernetes is an open source container orchestration engine for     
automating deployment, scaling, and management of containerized applications.     
The open source project is hosted by the Cloud Native Computing Foundation (CNCF).     

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


## References
- [kubernetes](https://kubernetes.io/docs/home/)
- [kubernetes up and running book](https://www.oreilly.com/library/view/kubernetes-up-and/9781491935668/)