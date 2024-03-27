## Reactive programming paradigm[^1]    
### Vert.x, Reactor, reactive streams specification, RxJava    
> As a first step in the direction of reactive programming, Microsoft created the Reactive Extensions (Rx) library in the .NET ecosystem. Then RxJava implemented reactive programming on the JVM.          
> As time went on, a standardization for Java emerged through the Reactive Streams effort, a specification that defines a set of interfaces and interaction rules for reactive libraries on the JVM.Its interfaces have been integrated into Java 9 under the Flow class.     

> The reactive programming paradigm is often presented in object-oriented languages as an extension of the Observer design pattern.    
> You can also compare the main reactive streams pattern with the familiar Iterator design pattern, as there is a duality to the Iterable-Iterator pair in all of these libraries.      
> One major difference is that, while an Iterator is pull-based, reactive streams are push-based.     

>Using an iterator is an imperative programming pattern, even though the method of accessing values is solely the responsibility of the Iterable.    
> Indeed, it is up to the developer to choose when to access the next() item in the sequence. In reactive streams, the equivalent of the above pair is Publisher-Subscriber.    
> But it is the Publisher that notifies the Subscriber of newly available values as they come, and this push aspect is the key to being reactive.     
> Also, operations applied to pushed values are expressed declaratively rather than imperatively: The programmer expresses the logic of the computation rather than describing its exact control flow.    

Today's software is shifting to more asynchronous, event-based solutions.For decades, the Observer pattern has been the go-to event infrastructure, but it is known to be bug-prone.     
Functional reactive programming (FRP) replaces Observer, radically improving the quality of event-based code.    
---
### Asynchronous, non-blocking code in JVM    
By writing asynchronous, non-blocking code, you let the execution switch to another active task that uses the same underlying resources and later comes back to the current process when the asynchronous processing has finished.
Java offers two models of asynchronous programming:     
- Callback
  - Asynchronous methods do not have a return value but take an extra callback parameter that gets called when the result is available.
  - e.g. kafkaProducer.send(producerRecord,callback);
- Futures 
  - Asynchronous methods immediately return a Future<T>. The asynchronous process computes a T value, but the Future object wraps access to it.    
  - e.g. ExecutorService#submit(runnable)
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