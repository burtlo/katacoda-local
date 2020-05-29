[Minikube](https://minikube.sigs.k8s.io/) is a CLI tool that provisions and
manages the lifecycle of single-node [Kubernetes
clusters](https://kubernetes.io/docs/concepts/#kubernetes-control-plane) running
inside Virtual Machines (VM) on your local system.

When you started this tutorial a Kubernetes cluster was already started for you.
The initialization process takes several minutes as it retrieves any necessary
dependencies and executes various container images.

Verify the status of the Minikube cluster.

```
minikube status
```{{execute}}

~> **Additional waiting:** Even if this last command completed successfully, you
may have to wait for Minikube to be available. If an error is displayed, try
again after a few minutes.

The host, kubelet, and apiserver report that they are running. The `kubectl`, a
CLI for running commands against Kubernetes cluster, is also configured to
communicate with this recently started cluster.
