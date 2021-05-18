```
               __
    ..=====.. |==|      ___________________
    ||     || |= |     < Database, please! >
 _  ||     || |^*| _    -------------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

The application requires access to a database. These credentials
are managed by the database secrets engine at the path `database` in a role named `readonly`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Get the database credentials from the database role.

```shell
vault read database/creds/readonly
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

Fail to get database credentials from the database role.

```shell
vault read database/creds/readonly
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
vault read -output-curl-string database/creds/readonly
```{{execute}}

The response displays the `curl` command.

```shell
curl -H "X-Vault-Request: true" -H "X-Vault-Token: $(vault print token)" http://localhost:8200/v1/database/creds/readonly
```

The HTTP verb by default is `GET` which translates to the `read` capability.
The requested URL displays the path `/database/creds/readonly`.

#### with the audit logs

Show the request's path and the request's operation.

```shell
cat log/vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"
```{{execute}}

The response displays the path `"database/creds/readonly"` and the operation `"read"`.


### with the API docs

Select the Database API tab to view the [Database API
documentation](https://www.vaultproject.io/api-docs/secret/databases).

The [generate
credentials](https://www.vaultproject.io/api-docs/secret/databases#generate-credentials)
operation describes the capability and the path. The operation requres the `GET`
HTTP verb which translates to the `read` capability. The templatized path
`/database/creds/:name` becomes `/database/creds/readonly` when the role name is provided.

## Enact the policy

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `apps-policy`.
3. Test the policy with  the `apps` user.
