Enable the `transit` secrets engine.

```shell-session
$ vault secrets enable transit
```

Create an encryption key to use for transit named `my_app_key`.

```shell-session
$ vault write -f transit/keys/my_app_key
```
