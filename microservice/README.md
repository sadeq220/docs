## Microservice patterns and architecture
This document aims to provide an overview of general Microservice patterns and architecture     
general Microservice patterns:    
- config server
- discovery service
- circuit breaker
- service gateway

Martin Fowler define a microservice *architectural style* as follows:
> In short, the microservice architectural style is an approach to developing a single application as a suite of small services,     
> each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API.      
> These services are built around business capabilities and independently deployable by fully automated deployment machinery.     
> There is a bare minimum of centralized management of these services, which may be written in different programming languages and use different data storage technologies.    

### Cloud native applications    
More applications are being deployed to the cloud(because of cost management) so write the application `cloud native` from the beginning.    

### Service Gateway(API Gateway)
**Central entrypoint** to microservices' cluster.    
central means that `cross-cutting service concerns` can be carried out in a single place without the    
individual development teams having to implement those concerns.     
service gateway is a `reverse proxy` to reach microservices' instances, acts as a single **Policy Enforcement Point**(PEP).    

Using a common library instead of separate gateway service has these drawbacks:    
- possibility of dependency hell by transitive dependencies of common library
- update and redeploy each microservice on every single change on cross-cutting concerns

### References
- [Martin Fowler microservice architectural style](https://martinfowler.com/articles/microservices.html)
- [Spring Microservices in Action, Second Edition](https://www.amazon.com/Spring-Microservices-Action-Second-Carnell/dp/1617296953/)