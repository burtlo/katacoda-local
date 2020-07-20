Request content served at `localhost:8080` from within the `devwebapp` pod.

```shell
kubectl exec \
  $(kubectl get pod -l app=devwebapp -o jsonpath="{.items[0].metadata.name}") \
  -- curl -s localhost:8080
```{{execute}}

The web application authenticates with the external Vault server using the root
token and returns the secret defined at the path `secret/data/devwebapp/config`.
This hard-coded approach is an effective solution if the address to the Vault
server does not change.