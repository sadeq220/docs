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

`java.security.spec.KeySpec`: A marker interface, A (transparent) specification of the underlying key material.      
for example PBEKeySpec contains   char[] password; byte[] salt = null; int iterationCount = 0; int keyLength = 0;    
    and PBKDF2HMAC SecretKeyFactory uses it to generate SecretKey.      
for example DSAKeySpec contains BigInteger x; BigInteger p; BigInteger q; BigInteger g;  
    and DSA KeyFactory uses it to generate DSAPrivateKey(which only contains BigInteger X)    

`java.security.Key`: The Key interface is the top-level interface for all keys.      
It defines the functionality shared by all key objects. All keys have three characteristics     
- String algorithm
- byte[] encoded form
  - The key is encoded according to a standard format (e.g. PKCS#8)
- String format
  - returns format that is used for encoding the key    
  - for example the name of the ASN.1 data format for private keys is PrivateKeyInfo, as defined by the PKCS #8 standard.    

`java.security.PrivateKey` and `javax.crypto.SecretKey` are extending this interface.    

### Java Secure Socket Extension (JSSE)
Implementation of TLS and DTLS    

#### SSL Certificate     
Bind public key value to a subject     

SSL certificate types:  
- Single Domain SSL certificate
- Wildcard SSL certificate
- Multi-Domain SSL Certificates (MDC)


SSL certificate validation level:   
- Domain Validation(DV)
- Organization Validation(OV)
- Extended Validation(EV SSL)

X.509 v3 certificates:    
X.509 defines a standard certificate format.    
Certificates are data structures that bind public key values to subjects.   
The binding is asserted by having a trusted CA digitally sign each certificate.    
`Certification Path`: certificate chain, from end-entity certificate(certificate of the public key owner signed by one CA) to root CA certificate(trust anchor)    
Self-signed certificates: are self-issued certificates where the digital signature may be verified by the public key bound into the certificate.     
X.509 also defines `certificate revocation lists`    

**For signature calculation**, the data that is to be signed is encoded using the ASN.1 distinguished encoding rules (DER).        
In the context of ASN.1 **encoding** and **serialization** are used interchangeably, and means to transform an object to a byte stream.    

> An HTTPS certificate is a type of file, like any other file.     
> Its contents follow a format defined by RFC 5280.      
> The definitions are expressed in ASN.1, which is a language used to define file formats or (equivalently) data structures.    

SSL certificate use ASN.1 1988 edition to encode data with its serialization format DER.    
A certificate represented in DER is often further encoded into PEM, which uses base64 to encode arbitrary bytes as alphanumeric characters.
#### ASN.1 and DER
ASN.1 is a standard interface description language for defining data structures that can be serialized and deserialized in a cross-platform way.     
The relevant standards are X.680 (defining the ASN.1 language, 1995 edition) and X.690 (defining the serialization formats DER and BER).    

ASN.1 is analogous to schemaful formats such as : protobuf, thrift, avro.    
In the context of ASN.1 **encoding** and **serialization** are used interchangeably, and means to transform an object to a byte stream.    
ASN.1’s main serialization format is “Distinguished Encoding Rules” (DER). They are a variant of “Basic Encoding Rules” (BER) with canonicalization added.     
A `SEQUENCE` is equivalent to “struct” in most programming languages. It holds a fixed number of fields of different types.      

ASN.1 Types:
- INTEGER (MAX 126 byte in DER encoding)
- string types:
  - PrintableString
  - UTF8String
  - IA5String
- byte stream types:
  - BIT STRING
  - OCTET STRING
- date and time types:
  - UTCTime (format as YYMMDDhhmm[ss])
  - GeneralizedTime

ASN.1 has a lot of string types, but     
For the purposes of HTTPS certificates you mostly have to care about `PrintableString`, `UTF8String`, and `IA5String`.      
PrintableString is a restricted subset of ASCII.    
IA5String allows nearly any ASCII character, and is used for email address, DNS names, and URLs in certificates.     

`BIT STRING` and `OCTET STRING` These can be used to hold unstructured data, like nonces or hash function output.
Comments begin with `--`   
```asn.1
 Certificate  ::=  SEQUENCE  {
        tbsCertificate       TBSCertificate,
        signatureAlgorithm   AlgorithmIdentifier,
        signatureValue       BIT STRING  }

   TBSCertificate  ::=  SEQUENCE  {
        version         [0]  EXPLICIT Version DEFAULT v1,
        serialNumber         CertificateSerialNumber,
        signature            AlgorithmIdentifier,
        issuer               Name,
        validity             Validity,
        subject              Name,
        subjectPublicKeyInfo SubjectPublicKeyInfo,
        issuerUniqueID  [1]  IMPLICIT UniqueIdentifier OPTIONAL,
                             -- If present, version MUST be v2 or v3
        subjectUniqueID [2]  IMPLICIT UniqueIdentifier OPTIONAL,
                             -- If present, version MUST be v2 or v3
        extensions      [3]  EXPLICIT Extensions OPTIONAL
                             -- If present, version MUST be v3
        }
```
The *signatureValue* field contains a digital signature computed upon the ASN.1 DER encoded *tbsCertificate*.     

BER is a `Type-Length-Value` encoding, just like Protocol Buffers and Thrift.      
That means that, as you read bytes that are encoded with BER, first you encounter a type, called in ASN.1 a tag.     
Type is a byte, or series of bytes, that tells you what type of thing is encoded: an INTEGER, or a UTF8String, or a structure, or whatever else.     
Length: a number that tells you how many bytes of data you’re going to need to read in order to get the value.      
Then, of course, comes the bytes containing the value itself.    

### References
- [Oracle JCA doc](https://docs.oracle.com/en/java/javase/11/security/java-cryptography-architecture-jca-reference-guide.html#GUID-2BCFDD85-D533-4E6C-8CE9-29990DEB0190)
- [cloudflare types of SSL](https://www.cloudflare.com/learning/ssl/types-of-ssl-certificates/)
- [RFC5280 X509 standard](https://www.rfc-editor.org/rfc/rfc5280)
- [lets encrypt ASN.1](https://letsencrypt.org/docs/a-warm-welcome-to-asn1-and-der/)