

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


The Vault server writes out operation logs and an audit log.

Show the operation logs.

```shell
cat ~/log/vault.log
```{{execute}}

Show the audit logs.

```shell
cat ~/log/vault_audit.log | jq
```{{execute}}
