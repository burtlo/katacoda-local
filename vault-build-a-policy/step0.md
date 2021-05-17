In this scenario, you are given a Vault server preconfigured and a database.

This server is development mode.

Export an environment variable for the `vault` CLI to address the target Vault
server.

```shell
export VAULT_ADDR=http://localhost:8200
```{{execute}}


Connect to the target Vault server.

```shell
vault status
```{{execute}}

You are now logged in as the `root` token. This is the highest priviledge token
and can perform any operation. This token is used for only initial configuration
or in development mode.

```shell

```{{execute}}
