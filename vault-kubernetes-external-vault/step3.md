The most direct way for a pod within the cluster to address Vault is with a
hard-coded network address defined within the application code or provided as an
environment variable. We've created and published a web application that you
will deploy with the Vault address overriden.

Retrieve the network address of the host.

```shell
hostname -I | awk '{print $1}'
```{{execute}}

Create a variable named EXTERNAL_VAULT_ADDR to capture the host address.

```shell
EXTERNAL_VAULT_ADDR=$(hostname -I | awk '{print $1}')
```{{execute}}

Create a Kubernetes service account for the pods to use to authenticate.

```shell
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: internal-app
EOF
```{{execute}}

Create a deployment with this web application.

```shell
cat <<EOF | kubectl apply -f -
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: devwebapp
  labels:
    app: devwebapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: devwebapp
  template:
    metadata:
      labels:
        app: devwebapp
    spec:
      serviceAccountName: internal-app
      containers:
      - name: app
        image: burtlo/devwebapp-ruby:k8s
        imagePullPolicy: Always
        env:
        - name: VAULT_ADDR
          value: "http://$EXTERNAL_VAULT_ADDR:8200"
EOF
```{{execute}}

The web application, targeting the external Vault, is deployed as a pod within
the default namespace.

Get all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `devwebapp` pod reports that is running and ready (`1/1`).
