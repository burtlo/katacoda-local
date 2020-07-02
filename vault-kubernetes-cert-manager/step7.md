The cert-manager enables you to define Issuers that interface with the Vault
certificate generating endpoints. These Issuers are invoked when a Certificate
is created.

When you configured Vault's Kubernetes authentication a Kubernetes service
account, named `issuer`, was granted the policy, named `pki`, to the certificate
generation endpoints.

Create a service account named `issuer` within the default namespace.

```shell
kubectl create serviceaccount issuer
```{{execute}}

The service account generated a secret that is required by the Issuer.

Get all the secrets in the default namespace.

```shell
kubectl get secrets
```{{execute}}

The issuer secret is displayed here as the secret prefixed with `issuer-token`.

Create a variable named `ISSUER_SECRET_REF` to capture the secret name.

```shell
ISSUER_SECRET_REF=$(kubectl get serviceaccount issuer -o json | jq -r ".secrets[].name")
```{{execute}}

Create an Issuer, named `vault-issuer`, that defines Vault as a certificate
issuer.

```shell
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1alpha2
kind: Issuer
metadata:
  name: vault-issuer
  namespace: default
spec:
  vault:
    server: http://vault.default
    path: pki/sign/example-dot-com
    auth:
      kubernetes:
        mountPath: /v1/auth/kubernetes
        role: issuer
        secretRef:
          name: $ISSUER_SECRET_REF
          key: token
EOF
```{{execute}}

The specification defines the signing endpoint and the authentication endpoint
and credentials.

- `metadata.name` sets the name of the Issuer to `vault-issuer`
- `spec.vault.server` sets the server address to the Kubernetes service created
  in the default namespace
- `spec.vault.path` is the signing endpoint created by Vault's PKI
  `example-dot-com` role
- `spec.vault.auth.kubernetes.mountPath` sets the Vault authentication endpoint
- `spec.vault.auth.kubernetes.role` sets the Vault Kubernetes role to `issuer`
- `spec.vault.auth.kubernetes/secretRef.name` sets the secret for the Kubernetes
  service account
- `spec.vault.auth.kubernetes/secretRef.key` sets the type to `token`.

Generate a certificate named `example-com`.

```shell
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1alpha2
kind: Certificate
metadata:
  name: example-com
  namespace: default
spec:
  secretName: example-com-tls
  issuerRef:
    name: vault-issuer
  commonName: www.example.com
  dnsNames:
  - www.example.com
EOF
```{{execute}}

The Certificate, named `example-com`, requests from Vault the certificate
through the Issuer, named `vault-issuer`. The common name and DNS names are
names within the allowed domains for the configured Vault endpoint.

View the details of the `example-com` certificate.

```shell
kubectl describe certificate.cert-manager example-com
```{{execute}}

The certifcate reports that it has been issued successfully.