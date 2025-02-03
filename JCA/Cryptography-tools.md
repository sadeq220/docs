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
- Secret Management
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

##### Authentication and Token
> tokens are the core method for authentication within Vault,     
> there is a token auth method (often referred to as token store).     
> This is a special auth method responsible for creating and storing tokens.

Tokens are the core method for authentication within Vault.    
Tokens in Vault are analogous to Session-ID within web-app.     
`Root tokens`: are tokens that have the root policy attached to them and can do anything in Vault. Anything.      
In addition, they are the only type of token within Vault that can be set to never expire without any renewal needed.     

Vault supports multiple auth methods including GitHub, LDAP, AppRole, and more. Upon authentication, a token is generated.        
Most authentication backends must be enabled before use, for example to use user-pass authentication
```sh
vault auth enable --path=auth/userpass userpass
```

`The approle auth method` allows machines or apps to authenticate with Vault-defined roles.     
This auth method is oriented to automated workflows (machines and services), and is less useful for human operators.      
It is recommended using **batch tokens** with the AppRole auth method.    
Auth methods must be configured in advance before users or machines can authenticate.    
```sh
# enable approle auth method
vault auth enable approle    
# create named role
vault write auth/approle/role/<role-name> \
    token_type=batch \
    secret_id_ttl=10m \
    token_ttl=20m \
    token_max_ttl=30m \
    token_policies=<policy-name> \
    secret_id_num_uses=40
# each token is associated with one or more policies 
# vault policy authorize a client to operate in vault
vault policy write user-management-policy user-management.hcl
# user-management.hcl file includes
#
#path "kv/data/user-management/*" {
#  capabilities = ["create", "read", "update", "delete", "list"]
#}
 
```
The approle auth method credentials include: `RoleID, SecretID`
The RoleID is a required argument (via role_id) at all times.    

Based on SecretID provision, approle authentication operates in two different mode: 
- pull mode(recommended)
  - If the SecretID used for login is fetched from an AppRole.
  - final authenticating client retrieves SecretID by using Response Wrapping.
- push mode(legacy)
  - If a "custom" SecretID is set against an AppRole by the client

```sh
#To read RoleID
$ vault read auth/approle/role/<role-name>/role-id
#To read SecretID(push mode)
vault write -force auth/approle/role/<role-name>/secret-id
```

> The RoleID is similar to a username; therefore, you will get the same value for a given role.     
> While SecretID is similar to a password that Vault will generate a new value every time you request it.

Use `periodic tokens` if the token should never expire.    
**Response wrap the SecretID**: instead of injecting a SecretID to the app, inject the token which wraps the SecretID     
```sh
#will return a wrapping_token that wraps the SecretID
vault write -wrap-ttl=60s -force auth/approle/role/<role-name>/secret-id
# to unwrap the wrapping_token
VAULT_TOKEN=<wrapping_token> vault unwrap
```
![vault_appRole_pullMode](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dtutorials%26version%3Dmain%26asset%3Dpublic%252Fimg%252Fvault-approle-workflow2.png%26width%3D934%26height%3D358&w=1080&q=75&dpl=dpl_51xHPhUfS8V8psmxZz4cyaQEQaWE) 
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
- [Vault appRole auth method](https://developer.hashicorp.com/vault/docs/auth/approle)
- [Vault appRole setup](https://developer.hashicorp.com/vault/tutorials/auth-methods/approle)
