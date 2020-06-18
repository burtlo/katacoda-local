The Secrets Store CSI driver *secrets-store.csi.k8s.io* allows Kubernetes to
mount multiple secrets, keys, and certs stored in enterprise-grade external
secrets stores into their pods as a volume. Once the Volume is attached, the
data in it is mounted into the container's file system.

First, clone a shallow copy of the secrets-store-csi-driver repository.

```shell
git clone --depth=1 https://github.com/kubernetes-sigs/secrets-store-csi-driver.git
```{{execute}}

Next, install the Kubernetes-Secrets-Store-CSI-Driver Helm chart at the path
`secrets-store-csi-driver/charts/secrets-store-csi-driver` with pods prefixed
with the name `csi`.

```shell
helm install csi secrets-store-csi-driver/charts/secrets-store-csi-driver
```{{execute}}

Finally, verify that a secrets-store-csi-driver pod, prefixed with
`csi`, is running in the `default` namespace.

```shell
kubectl get pods
```{{execute}}

The csi-secrets-store-csi-driver pod is displayed here as the pod prefixed with
`csi-secrets-store-csi-driver`.

Wait until the pod is
[`Running`](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase)
and ready (`3/3`).
