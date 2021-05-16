Set the address of the Vault server.

```shell
export VAULT_ADDR=http://0.0.0.0:8200
```{{execute}}

Verify that the Vault server is ready.

```shell
vault status
```{{execute}}

## Web Application

Explore defining policies for a web application.

The web application requires:

- social api keys from a KV-V2 secrets engine
- database credentials to verify authentication and load user details
- transit secret engine to authenticate users

The web application will use the `apps-password` policy.

```shell
vault policy read apps-policy
```{{execute}}

This policy is assigned to the `apps` userpass login that is granted the
`apps-policy`.

```shell
vault read auth/userpass/users/apps
```{{execute}}
