A service bound to all networks on the host, as you configured Vault, is
addressable by pods within Minikube's cluster by sending requests to the gateway
address of the Kubernetes cluster.

Start a minikube SSH session.

```shell
minikube ssh
```{{execute}}

Within this SSH session, retrieve the value of the Minikube host.

```shell
$ route -n | grep ^0.0.0.0 | awk '{ print $2 }'
```{{execute}}

Next, retrieve the status of the Vault server to verify network connectivity.

```shell
$ route -n | grep ^0.0.0.0 | awk '{ print $2 }' | xargs -I{} curl -s http://{}:8200/v1/sys/seal-status | jq
```{{execute}}

The output displays that Vault is initialized and unsealed. This confirms that
pods within your cluster are able to reach Vault given that each pod is
configured to use the gateway address.

Next, exit the Minikube SSH session.

```shell
exit
```{{execute}}

Finally, create a variable named EXTERNAL_VAULT_ADDR to capture the Minikube
gateway address.

```shell
EXTERNAL_VAULT_ADDR=$(minikube ssh "route -n | grep ^0.0.0.0 | awk '{ print \$2 }'" | tr -d '\r')
```{{execute}}

Verify that the variable contains the ip address you saw when executed in the
minikube shell.

```shell
echo $EXTERNAL_VAULT_ADDR
```{{execute}}

> **Additional output:** If the result contains additional networking
> information then you need to set the `EXTERNAL_VAULT_ADDR` manually with the
> value reported in the Minikube SSH session.