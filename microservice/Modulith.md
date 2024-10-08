## Modular Monolith(Modulith)
**A key motivation of the module system is strong encapsulation.**      
In the context of modular monolith, module represents a sub-package in the main package. it has a defined set of exposed APIs and required dependencies.      
Packages are a means of encapsulation, internal types and beans should not been accessed.      
There are various technologies to implement Modular Monolith:     
- Java 9 Platform Module System
- Spring Modulith  
- Across framework

This documentation is based on `Spring Modulith`:    
- > An API exposed to other modules implemented by Spring bean instances and application events published by the module.    
- > The application’s main package is the one that the main application class resides in.      
  > That is the class, that is annotated with @SpringBootApplication and usually contains the main(…) method used to run it.     
  > By default, each direct sub-package of the main package is considered an application module package.     
- by default, module base package types exposed to other modules, and other packages inside the module base are considered *internal implementation*    

> To keep application modules as decoupled as possible from each other, their primary means of interaction should be event publication and consumption.     

Event-based communication, is a key aspect to enable application module integration testing.    
Event-based communication in Spring Modulith, is possible through Spring core events, so-called `Spring events`     
```
// publisher
org.springframework.context.ApplicationEventPublisher#publishEvent(...)

// consumer
@org.springframework.transaction.event.TransactionalEventListener
void on(DomainEvent event){...}
```

To expose an internal module Spring bean to other modules use `NamedInterfaces`
```
@NamedInterface("restAPI")
package com.example.modulith_main.moduleA.exposed;
```
## The Event Publication Registry
> Spring Modulith ships with an event publication registry that hooks into the core event publication mechanism of Spring Framework.     
> On event publication, it finds out about the transactional event listeners that will get the event delivered and writes entries for each of them into an event publication log as part of the original business transaction.

Domain event consumption is synchronous by default.     
Spring modulith writes the even publication log into DB, it retries the event publication in case of listener failure.     
TransactionEventListener annotation is An EventListener that is invoked according to a **TransactionPhase**.     
so the event publication should be within an active transaction, and if not it would be discarded unless *fallbackExecution* flag is explicitly set.

## References
- [Java9 Modules](https://www.oracle.com/corporate/features/understanding-java-9-modules.html)
- [Spring Modulith](https://docs.spring.io/spring-modulith/reference/events.html)
- [Spring Modulith events](https://docs.spring.io/spring-modulith/docs/current-SNAPSHOT/reference/html/#events)
- [Across framework](https://www.iodigital.com/en/history/foreach/building-a-modular-monolith-with-spring-boot-and-across?srsltid=AfmBOoqFvgSDCTVKdtiymtLoRZSrUN4--WmUWtZcWCQ7CAIYstqgcUdx)
