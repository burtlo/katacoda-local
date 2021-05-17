The application requires access to API keys stored within Vault. These secrets
are maintained in a KV-V2 secrets engine enabled at the path `socials`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Show the secret.

```shell
vault kv get socials/twitter
```{{execute}}

## As the application

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Fail to show the secret.

```shell
vault kv get socials/twitter
```{{execute}}

## Discover the policy

### Error message

This error message is displayed when the command is executed.

```
Error making API request.

URL: GET http://0.0.0.0:8200/v1/sys/internal/ui/mounts/socials/twitter
Code: 403. Errors:

* preflight capability check returned 403, please ensure client's policies grant access to path "socials/twitter/"
```

The message displays the path that is required.

### Audit Logs

The file audit log writes JSON objects to the log file. The `jq` command parses,
filters and presents that data to you in a more digestable way.

Show the details of the last logged object.

```shell
cat vault_audit.log | jq -s ".[-1]"
```{{execute}}

Show the error message of the last logged object.

```shell
cat vault_audit.log | jq -s ".[-1].error"
```{{execute}}

Show the request of the last logged object.

```shell
cat vault_audit.log | jq -s ".[-1].request"
```{{execute}}

Show the request path and operation.

```shell
cat vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"
```{{execute}}


### API Documentation

Select the KV-V2 tab.

Read the https://www.vaultproject.io/api-docs/secret/kv/kv-v2#read-secret-version

Translate GET to `read`.
Translate `/secret/data/:path` to `/socials/data/twitter`.

## Define the policy

```hcl
path "socials/data/twitter" {
  capabilities = [ "read" ]
}
```

Append the policy definition to the local policy file

```shell
echo "
path \"socials/data/twitter\" {
  capabilities = [ \"read\" ]
}" >> apps-policy.hcl
```{{execute}}

## Apply the policy

Login as root.

```shell
vault login root
```{{execute}}

Update the `apps-policy`.

```shell
vault policy write apps-policy apps-policy.hcl
```{{execute}}

## Test the policy

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Attempt to get the Twitter keys from the path.

```shell
vault kv get socials/twitter
```{{execute}}