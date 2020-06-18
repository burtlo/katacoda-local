With the secret stored in Vault, the authentication configured and role created,
the `provider-vault` extension installed and the *SecretProviderClass* defined
it is finally time to create a pod that mounts the desired secret.

View the definition of the pod in
`pod-nginx.yml`{{open}}.

The pod, named `nginx`, defines and mounts a read-only
volume to `/mnt/secrets-store`. The objects defined in the `internal-database`
*SecretProviderClass* are written as files within that path.

Apply a pod named `nginx`.

```shell
kubectl apply --filename pod-nginx.yml
```{{execute}}

Verify that an nginx pod, named `nginx`, is running in the `default` namespace.

```shell
kubectl get pods
```{{execute}}

Finally, read the password secret written to the file system at
`/mnt/secrets-store/internal/database/config` on the nginx pod.

```shell
kubectl exec nginx -- cat /mnt/secrets-store/db-pass
```{{execute}}

The value displayed matches the `password` value for the secret
`internal/database/config`.