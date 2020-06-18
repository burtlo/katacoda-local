The Kubernetes-Secrets-Store-CSI-Driver Helm chart creates a definition for a
*SecretProviderClass* resource. This resource describes the parameters that are
given to the `provider-vault` executable. To configure it requires the IP
address of the Vault server, the name of the Vault Kubernetes authentication
role, and the secrets.

View the definition of the SecretProviderClass
`secret-provider-class-internal-database.yml`{{open}}.

The `internal-database` SecretProviderClass describes two objects. Each object
defines:

- `objectPath` is the path to the secret defined in Vault. Prefaced with a
  forward-slash.
- `objectName` a key name within that secret
- `objectVersion` - the version of the secret. When none is specified the latest
  is retrieved.

Create a SecretProviderClass named `internal-database`.

```shell
kubectl apply --filename secret-provider-class-internal-database.yml
```{{execute}}

Verify that the SecretProviderClass, named `internal-database` has been defined
in the default namespace.

```shell
kubectl describe SecretProviderClass internal-database
```{{execute}}