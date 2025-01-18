### Java Cryptography Architecture(JCA)
The Java Cryptography Architecture (JCA) is a major piece of the platform, and contains a `"provider" architecture` and a set of APIs for     
digital signatures, message digests (hashes), certificates and certificate validation, encryption (symmetric/asymmetric block/stream ciphers), key generation and management, and secure random number generation, to name a few. 

Security services(security algorithms e.g. AES-GCM) are implemented in providers (see [Cryptographic Service Providers](https://docs.oracle.com/en/java/javase/11/security/java-cryptography-architecture-jca-reference-guide.html#GUID-3E0744CE-6AC7-4A6D-A1F6-6C01199E6920))    
Since the *JCE* uses the same architecture as the JCA, the JCE should be more properly thought of as a part of the JCA.
JCA packages:
- java.security
- javax.crypto
- javax.crypto.spec
- javax.crypto.interfaces

`engine classes`:Algorithm independent classes that represents a *cryptography primitive*, and have a *getInstance(String)* method to specify an algorithm.    
- Cipher
- MessageDigest
- Signature
- KeyPairGenerator
- KeyFactory

`Cryptographic Service Providers`(CSP): implementation of one or more security services(algorithms)    
Each JDK installation has one or more providers installed and configured by default. For example Sun, SunJSSE, SunJCE    
Each CSP contains an Instance of "java.security.Provider" which contains the provider's name and lists all of the security services/algorithms it implements.       
![](./JCA-provider.png)


### References
- [Oracle JCA doc](https://docs.oracle.com/en/java/javase/11/security/java-cryptography-architecture-jca-reference-guide.html#GUID-2BCFDD85-D533-4E6C-8CE9-29990DEB0190)