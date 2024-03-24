## Reactive programming    
Today's software is shifting to more asynchronous, event-based solutions.For decades, the Observer pattern has been the go-to event infrastructure, but it is known to be bug-prone.     
Functional reactive programming (FRP) replaces Observer, radically improving the quality of event-based code.    

#### Traditional synchronous connection
Managing concurrent network connections by allocating a thread for each connection.     
This is the model in many technologies, such as Servlets in Jakarta EE (before additions in version 3).
The socket I/O operations are synchronous, so threads may block on I/O operations.    
For example, writing to a socket may block, such as until the underlying TCP buffer data has been sent over the network.    
---
A **callback** is an approach to reactive programming done imperatively.    
A spreadsheet is a great example of reactive programming: cells dependent on other cells automatically “react” when those other cells change.    
reactive-functional programming is solving is concurrency and parallelism.    