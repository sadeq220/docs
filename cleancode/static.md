### Class and ClassLoader
A class is a blueprint or template that defines the structure and behavior of objects(class instances).    
A ClassLoader is a part of the JVM that dynamically loads Java classes into memory at runtime.      
It's responsible for finding and loading class files (.class) when they're referenced for the first time.    
Class Loading Stages:    
- Loading - Bytecode loaded into memory
- Linking - Verification, preparation, resolution
- Initialization - Static variables initialized, static blocks executed

The byte[] containing class definitions (bytecode) resides in `Metaspace` (Java 8+) or PermGen (Java 7 and earlier),     
NOT in the heap or stack.
```java
public class LoadingProcess {
    public static void main(String[] args) {
        // Step-by-step what happens:
        
        // 1. ClassLoader reads .class file from disk/network
        //    -> byte[] classBytes = readFile("MyClass.class");
        
        // 2. JVM allocates memory in METASPACE for class metadata
        //    -> ClassMetadata* metadata = metaspaceAllocate(classBytes.length);
        
        // 3. Bytecode is copied to Metaspace
        //    -> memcpy(metadata->bytecode, classBytes, classBytes.length);
        
        // 4. Class object reference is created in HEAP
        //    -> Class<MyClass> clazz = new Class<>(metadata);
        
        Class<?> clazz = MyClass.class;  // 'clazz' reference on HEAP
                                         // points to metadata in METASPACE
    }
}
```

### JVM Memory Model
- Heap Memory
  - where class instances and arrays reside
  - it is managed by GC and divided into the Young Generation(Eden and Survivor spaces) and Old generation
- Stack Memory
  - where threads' call stack and local vars reside
- Method Area (Metaspace)
  - where Class objects reside
  - for GC efficiency separated from Heap
- Program Counter (PC) Register
  - where thread next instruction reside
- Native Method Stack
  - similar to JVM stack but for C/C++ 


### Static/Early method binding
**Why Static methods can't be overridden?**    
Static methods belong to the class itself (not instances) and are resolved(method binding) at compile-time, not runtime.     
What looks like "overriding" is actually method hiding.

Static binding ensures linking the function call and its function definition at compile-time only.     
It is also why it is synonymous with compile-time binding or early binding.    

Method overriding depends on runtime polymorphism (dynamic binding)        
Polymorphism is based on object type, but static method hiding is based on reference type.    
```java
// At compilation, the compiler decides:
// - WHICH method signature to call (based on reference type)
// - That this is a static method call
// - Generates bytecode instruction: INVOKESTATIC

public class CompileTime {
    public static void main(String[] args) {
        Parent parent = new Child();
        parent.staticMethod();  // Compiler sees: Parent.staticMethod()
                                // NOT Child.staticMethod()
        
        // Compiler generates bytecode equivalent to:
        // INVOKESTATIC Parent.staticMethod()V
    }
}
```
@Override annotation on static methods would cause compilation error!

### References