The web application needs access to the social keys.

The web application will use the `apps-password` policy.

```shell
vault policy read apps-policy
```{{execute}}

This policy is assigned to the `apps` userpass login that is granted the
`apps-policy`.

```shell
vault read auth/userpass/users/apps
```{{execute}}

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


## Discover the policy

### Error message

```
Error reading socials/data/twitter: Error making API request.

URL: GET http://0.0.0.0:8200/v1/socials/data/twitter
Code: 403. Errors:

* 1 error occurred:
        * permission denied
```

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



Login as root.

```shell
vault login root
```{{execute}}

Update the `apps-policy`.

```shell
vault policy write apps-policy apps-policy.hcl
```{{execute}}
