The volume mounted to the pod in step TODO expects a secret stored at
the path `internal/database/config`. When Vault is run in development a [KV
secret engine](https://www.vaultproject.io/docs/secrets/kv/kv-v2.html) is
enabled at the path `/secret`.

First, start an interactive shell session on the `vault-0` pod.

```shell
kubectl exec -it vault-0 /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ $`. Commands issued at this
prompt are executed on the `vault-0` container.

Enable kv-v2 secrets at the path `internal`.

```shell
vault secrets enable -path=internal kv-v2
```{{execute}}

Create a secret at path `internal/database/config` with a `username` and
`password`.

```shell
vault kv put internal/database/config username="db-readonly-username" password="db-secret-password"
```{{execute}}

Verify that the secret is readable at the path `secret/db-pass`.

```shell
vault kv get internal/database/config
```{{execute}}

Lastly, exit the the `vault-0` pod.

```shell
exit
```{{execute}}