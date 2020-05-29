Display the webapp deployment definition in `deployment-01-webapp.yml`.

```shell
cat deployment-01-webapp.yml
```{{execute T1}}

Deploy the webapp in Kubernetes by applying the file `deployment-01-webapp.yml`.

```shell
kubectl apply --filename deployment-01-webapp.yml
```{{execute T1}}

The web application runs as a pod within the `default` namespace.

Get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute T1}}

The web application pod is displayed here as the pod prefixed with `webapp`.

> **Additional waiting:** The deployment of the service requires the retrieval
> of the web application container from [Docker Hub](https://hub.docker.com/).
> This displays the STATUS of `ContainerCreating`. The pod reports that it is
> not ready (`0/1`).

This web application is running an HTTP service that is listening on port 8080.

In **another terminal**, [port
forward](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#port-forward)
all requests made to `http://localhost:8080` to the webapp pod on port 8080.

```shell
kubectl port-forward $(kubectl get pod -l app=webapp -o jsonpath="{.items[0].metadata.name}") 8080:8080
```{{execute T2}}

In the original terminal, perform a `curl` request at `http://localhost:8080`.

```shell
curl http://localhost:8080
```{{execute T1}}

The web application running on port 8080 in the _webapp_ pod:

- authenticates with the Kubernetes service account token
- receives a Vault token with the read capability at the
  `secret/data/webapp/config` path
- retrieves the secrets from `secret/data/webapp/config` path
- displays the secrets as JSON