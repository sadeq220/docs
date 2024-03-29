## Smalltalk programming language
> Smalltalk is a worldview, a way of thinking, a completely different programming paradigm.   
> The concepts at the heart of Smalltalk are so profound, and so foundational, that    
> all serious programmers should learn the language, even if they don't ever expect to actually use it professionally.     
> Learning C++, Java or C# is not any sort of substitute for learning the real thing. None of those languages satisfy Dr. Kay's definition of OOP.

In many code designing(Object-Oriented design) and architecture books they refer to object communication by messages.   
For example in "Growing Object-Oriented Software, Guided by Tests", there is a sentence as follows:
> Objects communicate by sending and receiving messages

and book values *communication patterns* more than well-designed class structure.   
All of their idea's about message passing comes from foundational pure Object-Oriented programming language called **Smalltalk**.  

Dr. Alan kay(inventor of Smalltalk) definition of OOP:
> OOP to me means only messaging, local retention and protection and hiding of state-process, and extreme late-binding of all things.    
> It can be done in Smalltalk and in LISP.

### Smalltalk objects and messages
In Smalltalk everything is an object.   
An object consists of some private memory and a set of operations.  
> design view: Objects represent the components of the Smalltalk-80 system.

A message is a request for an object to carry out one of its operations.    
> design view: Messages represent interactions between the components of the Smalltalk-80 system.

The set of messages to which an object can respond is called its `interface` with the rest of the system.   
The only way to interact with an object is through its interface.    
- A crucial property of an object is that its private memory can be manipulated only by its own operations.   
- A crucial property of messages is that they are the only way to invoke an object's operations.   
> Other programming environments also use objects and messages to facilitate modular design.[^1]

A class describes the implementation of a set of objects that all represent the same kind of system component.        
The individual objects described by a class are called its `instances`.    
Every object in the Smalltalk-80 system is an instance of a class.        
An object's private properties are a set of `instance variables` that make up its private memory and a set of `methods` that describe how to carry out its operations.   
Each method in a class tells how to perform the operation requested by a particular type of message.    
> design view: Instance variables represent the current state of an object.

The `primitive methods` are built into the virtual machine and cannot be changed by the Smalltalk-80 programmer.    
Primitive methods allow the underlying hardware and virtual machine structures to be accessed.    
```smalltalk
" instances of Integer use a primitive method to respond to the message + "
sum := 2 + 3.
```
### Smalltalk Expression Syntax
Objects interact by sending messages.Messages cause methods to be executed.      
- Literals describe certain constant objects, such as numbers and character strings.
- Message expressions describe messages to receivers. The value of a
  message expression is determined by the method the message invokes.

The selector of a message determines which of the receiver's operations will be invoked.    
The arguments are other objects that are involved in the selected operation.
```smalltalk
receiverObject messageSelector: messageArg
```
`Keyword Messages` The general type of message with one or more arguments is the keyword message.    
The selector of a keyword message is composed of one or more keywords, one preceding each argument.    
A keyword is a simple identifier with a trailing colon.
```smalltalk
" message selector of following message is keyword1:keyword2: "
receiverObject keyword1: arg keyword2: arg
```
`value of the message expression:`    
**receiver always returns a value for the message expression.**   
Returning a value indicates that the response to the message is complete.    
The default value returned is usually the receiver itself.    

**messages are parsed from left to right**    
When unary, binary, and keyword messages appear in the same expression without parentheses,    
the unaries are sent first, the binaries next, and the keyword last.
```smalltalk
"fist + message evalutes and then *"
offset + index * 2 

"the following message is evaluted as 'bigFrame width: ((smallFrame width) • 2)'"
bigFrame width: smallFrame width • 2
```
**Cascading** send multiple messages to the same object.
A `cascaded message` expression consists of one description of the receiver followed by several messages separated by semicolons.
```smalltalk
"the following cascaded message sends two messages to Transcript object"
"first message is keyword message with show: selector"
"second message is unary message cr "
Transcript show: 'arg' ; cr.
```
The assignment operator `:=` used to change the object that variable refers to.
```smalltalk
| variable |
variable := object
```
**Blocks [] are also objects**    
A block represents a deferred sequence of actions.    
The sequence of actions a block describes will take place when the block receives the unary message *value*.        
The object returned after a value message is sent to a block is the value of the last expression in the sequence.     
```smalltalk
| variable |
variable := [ object1 message.
              object1 keyword: arg.
              object2 message.
              ]
"sending the value message to block object will execute its statements"
variable value.
```
**pseudo-variable name** is an identifier that refers to an object.     
Three important pseudo-variable names are `nil`, true, and false.   
`self` and `super` are also pseudo-variable names.    
> nil: refers to an object used as the value of a variable when     
> no other object is appropriate . Variables that have not been otherwise initialized refer to nil.   

A class's name automatically becomes the name of a globally shared variable.     
The value of that variable is the object representing the class.    
Since class names are the names of shared variables, they must be capitalized.    

Variables that are shared by more than one object come in groups called `pools`.    

A `protocol description` lists the messages in the instances' message interface.    
describes *what* functionality, not *how* it is implemented.

### References
- [Smalltalk-80: The Language and its Implementation](https://dl.acm.org/doi/book/10.5555/273)
- [Smalltalk.org article](http://www.smalltalk.org/articles/article_20100320_a3_Getting_The_Message.html)
- [gnu smalltalk](https://www.gnu.org/software/smalltalk/manual/html_node/Syntax.html)

[^1]: mark fisher also says "Object-oriented software is all about modularity"