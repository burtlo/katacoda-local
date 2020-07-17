```shell-session
vault secrets enable ssh
```

Next, create a role.

```shell-session
vault write ssh/roles/otp_key_role key_type=otp \
      default_user=ubuntu \
      cidr_list=0.0.0.0/0
```

