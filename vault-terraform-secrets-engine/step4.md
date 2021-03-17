The applications or users that require the Terraform credentials read them
from the secret engine's _my-user_ role.

Read credentials from the `my-user` role.

```shell
vault read terraform/creds/my-user
```{{execute}}

The Terraform credentials are displayed as the `token` value. The `token_id`
represents its unique identifier that Terraform Cloud uses to maintain that ID.

Create a variable to store the token created from the `my-user` role.

```shell
CREATED_TF_TOKEN=$(vault read -format=json terraform/creds/my-user | jq -r ".data.token")
```{{execute}}

Request all the authentication token IDs for the user account authenticating
with the `CREATED_TF_TOKEN` token.

```shell
curl \
  --header "Authorization: Bearer $CREATED_TF_TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request GET \
  https://app.terraform.io/api/v2/users/$USER_ID/authentication-tokens | jq -r ".data[].id"
```{{execute}}

The results of the request authenticates with the new token and returns the
list of all the token ids generated.
