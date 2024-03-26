## Reactive programming paradigm[^1]    
### Vert.x, RxJava, Reactor, reactive streams specification
Today's software is shifting to more asynchronous, event-based solutions.For decades, the Observer pattern has been the go-to event infrastructure, but it is known to be bug-prone.     
Functional reactive programming (FRP) replaces Observer, radically improving the quality of event-based code.    

---
#### Traditional synchronous connection
Managing concurrent network connections by allocating a thread for each connection.     
This is the model in many technologies, such as Servlets in Jakarta EE (before additions in version 3).
The socket I/O operations are synchronous, so threads may block on I/O operations.    
For example, writing to a socket may block, such as until the underlying TCP buffer data has been sent over the network.   

The idea behind non-blocking I/O is to request a (blocking) operation,    
 and move on to doing other tasks until the operation result is ready.(apply a level of indirection[^2] like creational design patterns)    

---
#### reactive Imperative - reactive functional
A **callback** is an approach to reactive programming done imperatively.    
A spreadsheet is a great example of reactive programming: cells dependent on other cells automatically “react” when those other cells change.        
Reactive-functional programming is an abstraction,an abstraction on top of imperative systems—that allows us to program asynchronous and event-driven.    
Reactive-functional programming is solving is concurrency and parallelism.    

### References
- [Reactor doc](https://projectreactor.io/docs/core/release/reference/#getting-started)

[^1]: paradigm refers to a fundamental way of thinking about and approaching a particular subject or problem. comprehensive philosophy and methodology behind Reactive Programming, including its principles, techniques, and best practices.      
Similar to the Reactive Programming paradigm, Object-Oriented Programming paradigm provides a fundamental way of structuring and designing software systems. It offers a set of principles and practices for modeling real-world entities, promoting modularity, reusability, and maintainability in software development.     
[^2]: From OCP8, Level of indirection is a general term for solving a software design problem by conceptually separating the task into multiple levels.