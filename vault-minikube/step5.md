Vault generated an initial [root
token](https://www.vaultproject.io/docs/concepts/tokens.html#root-tokens) when
it was initialized.

View the root token found in `cluster-keys.json`.

```shell
cat cluster-keys.json | jq -r ".root_token"
```{{execute}}

First, start an interactive shell session on the `vault-0` pod.

```shell
kubectl exec -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ $`. Commands issued at this
prompt are executed on the `vault-0` container.

Vault is now ready for you to login with the initial root token.

Login with the root token.

```shell
vault login s.VgQvaXl8xGFO1RUxAPbPbsfN
```{{execute}}

Enable kv-v2 secrets at the path `secret`.

```shell
vault secrets enable -path=secret kv-v2
```{{execute}}

~> **Learn more:** This guide focuses on Vault's integration with Kubernetes and
not interacting with the key-value secrets engine. For more information refer to
the [Static Secrets: Key/Value Secret](/vault/developer/sm-static-secrets)
guide.

Create a secret at path `secret/webapp/config` with a `username` and `password`.

```shell
vault kv put secret/webapp/config username="static-user" password="static-password"
```{{execute}}

Verify that the secret is defined at the path `secret/webapp/config`.

```shell
vault kv get secret/webapp/config
```{{execute}}

You successfully created the secret for the web application.
