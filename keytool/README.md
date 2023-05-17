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
