### Lock-Free Algorithms   
In Java the package `java.util.concurrent.atomic` provides **lock-free thread-safe programming on single variables**.   
Until Java 8 classes in this package used **volatile variable** and a method with signature:
```
boolean compareAndSet(expectedValue, updateValue);
```
From Java 11 onwards, atomic classes used `VarHandle` instead of volatile variable  

>Atomic classes are designed primarily as building blocks for implementing non-blocking data structures and related infrastructure classes. 
>The compareAndSet method is not a general replacement for locking. 
>It applies only when critical updates for an object are confined to a single variable.   

### Context Switch   
Operating systems(kernel) use a `thread scheduler` to determine which threads should be currently executing.   
When a thread's allotted time is complete but the thread has not finished processing, a context switch occurs.   
A **context switch** is the process of storing a thread's current state and then interrupted by `thread scheduler` 