## Smalltalk programming language
> Smalltalk is a worldview, a way of thinking, a completely different programming paradigm.   
> The concepts at the heart of Smalltalk are so profound, and so foundational, that    
> all serious programmers should learn the language, even if they don't ever expect to actually use it professionally.     
> Learning C++, Java or C# is not any sort of substitute for learning the real thing. None of those languages satisfy Dr. Kay's definition of OOP.

In many code designing and architecture books they refer to object communication by messages.   
For example in "Growing Object-Oriented Software, Guided by Tests", there is a sentence as follows:
> Objects communicate by sending and receiving messages

and book values *communication patterns* more than well-designed class structure.   
All of their idea's about message passing comes from foundational pure Object-Oriented programming language called **Smalltalk**.

### Smalltalk objects and messages
In Smalltalk everything is an object.   
An object consists of some private memory and a set of operations.    
A message is a request for an object to carry out one of its operations.    
The set of messages to which an object can respond is called its `interface` with the rest of the system.   
The only way to interact with an object is through its interface.    
- A crucial property of an object is t h a t its private memory can be manipulated only by its own operations.   
- A crucial property of messages is that they are the only way to invoke an object's operations.   
> Other programming environments also use objects and messages to facilitate modular design.[^1]

A class describes the implementation of a set of objects that all represent the same kind of system component.        
The individual objects described by a class are called its `instances`.    
Every object in the Smalltalk-80 system is an instance of a class.        
An object's private properties are a set of `instance variables` that make up its private memory and a set of `methods` that describe how to carry out its operations.   
Each method in a class tells how to perform the operation requested by a particular type of message.    
The `primitive methods` are built into the virtual machine and cannot be changed by the Smalltalk-80 programmer.    
Primitive methods allow the underlying hardware and virtual machine structures to be accessed.    
```smalltalk
" instances of Integer use a primitive method to respond to the message + "
sum := 2 + 3.
```
### References
- [Smalltalk-80: The Language and its Implementation](https://dl.acm.org/doi/book/10.5555/273)

[^1]: mark fisher also says "Object-oriented software is all about modularity"