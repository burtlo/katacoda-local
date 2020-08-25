Our example user alice has previously authenticated to Vault and her token has a policy attached which provides the capability needed to request a new OpenLDAP credential from the learn role.

View the policies required to perform the **alice** responsibilities in this
scenario.

```shell
cat alice-policy.hcl
```{{execute}}

Login with the `alice` user using the `userpass` authentication method.

```shell
vault login -method=userpass \
  username=alice \
  password=alice-password
```{{execute}}


Generate credentials from the `learn` role.

```shell
vault read openldap/static-cred/learn
```{{execute}}

Perform an LDAP search with the generated `dn` and `password`.

```shell
$ ldapsearch -D 'cn=alice,ou=users,dc=learn,dc=example' \
    -w <PASSWORD>
```{{execute}}