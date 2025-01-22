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

### References
- [hashicorp vault doc](https://developer.hashicorp.com/vault/docs/what-is-vault)
