The Terraform secrets engine is configured by default to communicate with
Terraform Cloud. The Terraform Cloud API key is set in the configuration to
authenticate.

Configure the Terraform secrets engine to use the `TF_TOKEN` token.

```shell
vault write terraform/config token=$TF_TOKEN
```{{execute}}
