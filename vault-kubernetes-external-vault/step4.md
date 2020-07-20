An external Vault may not have a static network address that services within the
cluster can rely upon. When Vault's network address changes each service also
needs to change to continue its operation. Another approach to manage this
network address is to define a Kubernetes service and endpoints.

A _service_ creates an abstraction around pods or an external service. When an
application running in a pod requests the service, that request is routed to the
endpoints that share the service name.

Deploy a service named `external-vault` and a corresponding endpoint configured
to address the `EXTERNAL_VAULT_ADDR`.

```shell
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Service
metadata:
  name: external-vault
  namespace: default
spec:
  ports:
  - protocol: TCP
    port: 8200
---
apiVersion: v1
kind: Endpoints
metadata:
  name: external-vault
subsets:
  - addresses:
      - ip: $EXTERNAL_VAULT_ADDR
    ports:
      - port: 8200
EOF
```{{execute}}

Verify that the `external-vault` service is addressable from within the
`devwebapp` pod.

```shell
kubectl exec \
  $(kubectl get pod -l app=devwebapp -o jsonpath="{.items[0].metadata.name}") \
  -- curl -s http://external-vault:8200/v1/sys/seal-status | jq
```{{execute}}

Pod definitions may now reach the Vault server through the Kubernetes service.

Apply the deployment, named `devwebapp-through-service`, that sets the
`VAULT_ADDR` to the `external-vault` service.

```shell
cat <<EOF | kubectl apply -f -
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: devwebapp-through-service
  labels:
    app: devwebapp-through-service
spec:
  replicas: 1
  selector:
    matchLabels:
      app: devwebapp-through-service
  template:
    metadata:
      annotations:
        vault.hashicorp.com/agent-inject: "true"
        vault.hashicorp.com/role: "devweb-app"
        vault.hashicorp.com/agent-inject-secret-credentials.txt: "secret/data/devwebapp/config"
      labels:
        app: devwebapp-through-service
    spec:
      containers:
      - name: app
        image: burtlo/devwebapp-ruby:k8s
        imagePullPolicy: Always
        env:
        - name: SERVICE_PORT
          value: "8080"
        - name: VAULT_ADDR
          value: "http://external-vault:8200"
EOF
```{{execute}}

This deployment named `devwebapp-through-service` creates a pod that addresses
Vault through the service instead of the hard-coded network address.

Get all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `devwebapp-through-service` pod is running and ready (`1/1`).

Finally, request content served at `localhost:8080` from within the
`devwebapp-through-service` pod.

```shell
kubectl exec \
  $(kubectl get pod -l app=devwebapp-through-service -o jsonpath="{.items[0].metadata.name}") \
  -- curl -s localhost:8080
```{{execute}}

The web application authenticates and requests the secret from the external
Vault server that it found through the `external-vault` service.