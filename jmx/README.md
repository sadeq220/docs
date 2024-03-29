## JMX Technology    
JMX(Java Management Extensions) technology, is a part of javaEE specifications. under the namespace of `javax.management.*`   
The JMX technology is also a standard part of the Java Platform, Standard Edition (Java SE platform).   
JMX was developed as two Java Specification Requests (JSRs):
- JSR 3: Java Management Extensions (JMX) Specification
- JSR 160: Java Management Extensions (JMX) Remote API   

You can use JMX technology to monitor and manage the Java Virtual Machine (Java VM).    
In short, JMX technology for `JVM network management and monitoring`.
### Managed Bean (MBean)
An MBean is a managed Java object, similar to a JavaBeans component, that follows the design patterns set forth in the JMX specification.     
An MBean can represent a device, an application, or any resource that needs to be managed.       
#### To remind `JavaBean`
JavaBean first introduced in JDK 1.1 specification as: 
>A Java Bean is a reusable software component that can be manipulated visually in a builder tool.    

> all beans must be serializable, have a zero-argument constructor, and allow access to properties using getter and setter methods.[^1]

OCP8 defines a JavaBean as:
> A JavaBean is a design principle for encapsulating data in an object in Java.    

There is also a `JavaBeans pattern`[^2], in which you call a parameterless constructor to create the object 
and then call setter methods to set each required parameter and each
optional parameter of interest.     
For example spring **ThreadPoolTaskExecutor** class is a JavaBean and allows for configuring a java ThreadPoolExecutor in bean style.    

### References
- [oracle JMX doc](https://docs.oracle.com/en/java/javase/20/jmx/introduction-jmx-technology.html#GUID-72DCB4C1-93F8-4F37-B46E-2C708139C8A5)
- [oracle MBean doc](https://docs.oracle.com/javase/tutorial/jmx/mbeans/index.html)
- [JavaBean specification](https://download.oracle.com/otndocs/jcp/7224-javabeans-1.01-fr-spec-oth-JSpec/)

[^1]: wikipedia JavaBeans
[^2]: joshua bloch, Effective java
