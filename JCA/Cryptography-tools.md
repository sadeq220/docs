### Cryptography Tools
Tools to generate keys, manage keys, encrypt, sign, manage PKI workflows
- Hashicorp Vault
- openssl
- keytool
- gpg

#### Hashicorp Vault
HashiCorp Vault is an `identity-based secrets` and encryption management system.     
A secret is anything that you want to tightly control access to, such as tokens, API keys, passwords, encryption keys or certificates.    

Vault helps organizations implement a complete security lifecycle management system.     
Vault allows you to store, manage, and retrieve secrets, generate on-demand credentials to common platforms such as AWS, GCP, K8s, and Azure,    
`manage common PKI workflows`,     
and encrypt data for applications in transit and at rest.     

Vault use cases:    
- Centralize and secure credentials(Passwords, API keys, ...)
- Key Management System(Manage Private and secret keys' lifecycle)
- Microservice platform config server
- Data Encryption

##### Secrets Engines
Secrets engines are components which store, generate, or encrypt data.     
Some secrets engines simply store and read data - like encrypted Redis/Memcached.     
Each secrets engine is isolated to its path.    
for example KV secrets engine may be enabled at *kv/*
```bash
# to enable kv secrets engines at kv/ path
$ vault secrets enable -path kv -version 2 kv
```

##### How works
Clients use TLS to verify the identity of the server and to establish a secure communication channel.      
Servers require that a client provides a client token for every request which is used to identify the client.     

All server-to-server traffic between Vault instances within a cluster (i.e, high availability, enterprise replication or integrated storage)    
uses mutually-authenticated TLS(mTLS)

Vault uses a security barrier for all requests made to the storage backend.    
The security barrier automatically encrypts all data leaving Vault using a 256-bit AES-GCM cipher with 96-bit nonces.     

### References
- [hashicorp Vault doc](https://developer.hashicorp.com/vault/docs/what-is-vault)
- [Vault secrets engines](https://developer.hashicorp.com/vault/docs/secrets)
