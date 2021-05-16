The web application needs access to the social keys.


```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Attempt to read the Twitter keys from the path.

```shell
vault kv read socials/twitter
```{{execute}}

TODO

Login as root.

```shell
vault login root
```{{execute}}

Update the `apps-policy`.

```shell
vault policy write apps-policy apps-policy.hcl
```{{execute}}
