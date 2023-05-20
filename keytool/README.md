### Java keytool command   
keytool Manages a keystore (database) of cryptographic keys, X.509 certificate chains, and trusted certificates.

### Java KeyStore (JKS)   
This class represents a storage facility for cryptographic keys and certificates.

A KeyStore manages different types of **entries** . Each type of entry implements the KeyStore.Entry interface. Three basic KeyStore.Entry implementations are provided:   
- KeyStore.PrivateKeyEntry
  - It is also accompanied by a certificate chain for the corresponding public key.
  - It is used for self-authentication.
- KeyStore.SecretKeyEntry
  - holds a cryptographic SecretKey( symmetric key).
- KeyStore.TrustedCertificateEntry
  - contains a single public key Certificate belonging to another party.
  - It is used to authenticate other parties.

Each entry in a keystore is identified by an "alias" string   
Read a keystore by:
```bash
keytool -list -keystore <keystore>
```
KeyStore formats(types):   

- PKCS12
>  archive file format for storing many cryptography objects as a single file. It is commonly used to bundle a private key with its X.509 certificate or to bundle all the members of a chain of trust.   
The filename extension for PKCS#12 files is .p12 or .pfx.

- JKS   
> Java KeyStore(JKS) is a java proprietary format.it cannot be used to store secret keys. It is recommended to migrate to PKCS12 which is an industry standard format.   
the filename extension is .jks.
