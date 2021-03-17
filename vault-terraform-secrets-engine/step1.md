The Terraform secrets engine generates Terraform Cloud tokens dynamically based
on configured roles.

Enable the Terraform secrets engine at the `terraform/` path.

```shell
vault secrets enable terraform
```{{execute}}

The Terraform secrets engine is enabled.