The secret engine is configured with the credentials that you provided it. These
credentials are used through roles that you define for each secret engine. A
role is a logical name within Vault that maps to Terraform Cloud credentials.
These roles are defined for an organization, a team, or a user.

Request the Terraform user ID for the account associated with the `TF_TOKEN`.

```shell
curl -s \
  --header "Authorization: Bearer $TF_TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request GET \
  https://app.terraform.io/api/v2/account/details | jq -r ".data.id"
```{{execute}}

This unique ID is required to generate credentials for this user.

Create a variable to store the user ID.

```shell
USER_ID=$(!!)
```{{execute}}

Create a role named `my-user` with the `USER_ID` and a time-to-live of 2
minutes.

```shel
vault write terraform/role/my-user user_id=$USER_ID ttl=2m
```{{execute}}

This role is ready to generate credentials for this user that stay valid for
two minutes.
