## Microservice patterns and architecture
This document aims to provide an overview of general Microservice patterns and architecture     
general Microservice patterns:    
- config server
- discovery service
- circuit breaker
- API Gateway

Martin Fowler define a microservice *architectural style* as follows:
> In short, the microservice architectural style is an approach to developing a single application as a suite of small services,     
> each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API.      
> These services are built around business capabilities and independently deployable by fully automated deployment machinery.     
> There is a bare minimum of centralized management of these services, which may be written in different programming languages and use different data storage technologies.    

Characteristics of microservice architecture:
- Componentization via Services
    - **Component** definition: component is a unit of software that is independently replaceable and upgradeable.   
    - two form of components are *library* and *service*.
    - Components are a form of module, with the additional property of independent replacement.
- Organized around Business Capabilities
    - each microservice should represent one specific **business domain**     
    - Consequently the teams are cross-functional, including the full range of skills required for the development: user-experience, database, and project management.     
  
### Cloud native applications    
More applications are being deployed to the cloud(because of cost management) so write the application `cloud native` from the beginning.    

### API Gateway(Service Gateway,edge service)
**Central entrypoint** to microservices' cluster.    
central means that `cross-cutting service concerns` can be carried out in a single place without the    
individual development teams having to implement those concerns.     
service gateway is a `reverse proxy` to reach microservices' instances, acts as a single **Policy Enforcement Point**(PEP).    

Using a common library instead of separate gateway service has these drawbacks:    
- possibility of dependency hell by transitive dependencies of common library
- update and redeploy each microservice on every single change on cross-cutting concerns

API Gateway is using **predicates** and **filters** to route(proxy) requests.     
Filters are used to enforce a consistent set of policies like security, logging. These policies are considered `cross-cutting concerns`.     
practical filters would be:   
- Pre-filter that adds **Correlation ID** header on each request(if not present) to trace user transaction flow

### References
- [Martin Fowler microservice architectural style](https://martinfowler.com/articles/microservices.html)
- [Spring Microservices in Action, Second Edition](https://www.amazon.com/Spring-Microservices-Action-Second-Carnell/dp/1617296953/)
- [Martin Fowler component definition](https://martinfowler.com/bliki/SoftwareComponent.html)