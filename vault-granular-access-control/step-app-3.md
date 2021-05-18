```
               __
    ..=====.. |==|      _____________________
    ||     || |= |     < Encryption, please! >
 _  ||     || |^*| _    ---------------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

The application requires access to Vault's transit encryption service. This encryption service is maintained in a transit secrets engine enabled at the path `transit` with a key named `app-auth`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Encrypt the plaintext with the transit key.

```shell
vault write transit/encrypt/app-auth plaintext=$(base64 <<< "my secret data")
```{{execute}}


## As the application

The policies defined for `apps` do not grant it the capability to perform this
operation.

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Fail to encrypt the plaintext with the transit key.

```shell
vault write transit/encrypt/app-auth plaintext=$(base64 <<< "my secret data")
```{{execute}}

## Discover the policy change required

Login with the `root` user.

```shell
vault login root
```{{execute}}

#### with the CLI flags

The `vault` CLI communicates direclty with Vault. It can optionally display
the the HTTP verb and path requested by a command.

Show the *curl* command for getting the secret

```shell
vault write -output-curl-string transit/encrypt/app-auth plaintext=$(base64 <<< "my secret data")
```{{execute}}

The response displays the `curl` command.

```shell
curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Token: $(vault print token)" -d '{"plaintext":"bXkgc2VjcmV0IGRhdGEK"}' http://localhost:8200/v1/transit/encrypt/app-auth
```

The HTTP verb is `PUT` which translates to the `update` capability.
The requested URL displays the path `/transit/encrypt/app-auth`.

#### with the audit logs

Show the request's path and the request's operation.

```shell
cat log/vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"
```{{execute}}

The response displays the path `"transit/encrypt/app-auth"` and the operation `"update"`.

### with the API docs

Select the Transit API tab to view the [Transit API
documentation](https://www.vaultproject.io/api-docs/secret/transit).

The [encrypt
data](https://www.vaultproject.io/api-docs/secret/transit#encrypt-data)
operation describes the capability and the path. The operation requres the
`POST` HTTP verb which translates to the `create` and/or `update` capability. The
templatized path `/transit/encrypt/:name` becomes `/transit/encrypt/app-auth` when
the key name is provided.

## Enact the policy

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `apps-policy`.
3. Test the policy with  the `apps` user.
