Keep certificate lifetimes short to align with Vault's philosophy of
short-lived secrets.

Request a new certificate for the `test.example.com` domain based on the
`example-dot-com` role.

```shell
vault write pki_int/issue/example-dot-com common_name="test.example.com" ttl="24h"
```{{execute}}

The response contains the PEM-encoded private key, key type and certificate
serial number.