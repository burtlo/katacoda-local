```shell-session
vault login -method=userpass username=bob password=training
```

Generate an OTP credential for an IP of the remote host belongs to the
`otp_key_role`:

```shell-session
vault write ssh/creds/otp_key_role ip=<REMOTE_HOST_IP>
```

**Example:**

```shell-session
vault write ssh/creds/otp_key_role ip=192.0.2.10
```

