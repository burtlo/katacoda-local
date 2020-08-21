If a certificate must be revoked, you can easily perform the revocation action
which will cause the CRL to be regenerated. When the CRL is regenerated, any
expired certificates are removed from the CRL.

In certain circumstances, you may wish to revoke an issued certificate.

To revoke a certificate, execute the following command.

```shell
vault write pki_int/revoke serial_number=<serial_number>
```

**Example:**

```shell
vault write pki_int/revoke \
        serial_number="48:97:82:dd:f0:d3:d9:7e:53:25:ba:fd:f6:77:3e:89:e5:65:cc:e7"
```
