The credentials are managed by the lease ID and remain valid for the lease
duration (TTL) or until revoked. Once revoked the credentials are no longer
valid.

List the existing leases.

```shell
vault list sys/leases/lookup/terraform/creds/my-user
```{{execute}}

All valid leases for Terraform credentials are displayed.

Create a variable that stores the first lease ID.

```shell
LEASE_ID=$(vault list -format=json sys/leases/lookup/terraform/creds/my-user | jq -r ".[0]")
```{{execute}}

Renew the lease for the database credential by passing its lease ID.

```shell
vault lease renew terraform/creds/my-user/$LEASE_ID
```{{execute}}

The TTL of the renewed lease is set to `5m`.

Revoke the lease without waiting for its expiration.

```shell
vault lease revoke terraform/creds/my-user/$LEASE_ID
```{{execute}}

List the existing leases.

```shell
vault list sys/leases/lookup/terraform/creds/my-user
```{{execute}}

The lease is no longer valid and is not displayed.

Read new credentials from the `my-user` role.

```shell
vault read terraform/creds/my-user
```{{execute}}

All leases associated with a path may be removed.

Revoke all the leases with the prefix `terraform/creds/my-user`.

```shell
vault lease revoke -prefix terraform/creds/my-user
```

The `prefix` flag matches all valid leases with the path prefix of
`terraform/creds/my-user`.

List the existing leases.

```shell
vault list sys/leases/lookup/terraform/creds/my-user
```{{execute}}

All the leases with this path as a prefix have been revoked.
