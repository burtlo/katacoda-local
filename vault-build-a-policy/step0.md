Explore defining policies for two roles. A web application and an administrator.

The web application requires:

- reads social api keys from a KV-V2 secrets engine
- database credentials to verify authentication and load user details
- transit secret engine to authenticate users

The web application administrator requires:

- update social api keys from a KV-V2 secrets engine
- manage database credential leases and the secret engine configuration
- rotate and update transit secret engine keys

Start with defining an apps policy.


```shell
export VAULT_ADDR=http://0.0.0.0:8200
```{{execute}}

```shell
vault status
```{{execute}}