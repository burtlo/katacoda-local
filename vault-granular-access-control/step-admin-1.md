```
                    ____
                  .'* *.'
               __/_*_*(_
              / _______ \     _______
             _\_)/___\(_/_   < New
            / _((\- -/))_ \      keys. >
            \ \   (-)   / /      ------
             ' \___.___/ '
            / ' \__.__/ ' \
           / _ \ - | - /_  \
          (   ( .;''';. .'  )
          _\"__ /    )\ __"/_
            \/  \   ' /  \/
             .'  '...' ' )
              / /  |  \ \
             / .   .   . \
            /   .     .   \
           /   /   |   \   \
         .'   /    b    '.  '.
     _.-'    /     Bb     '-. '-._
 _.-'       |      BBb       '-.  '-.
(________mrf\____.dBBBb.________)____)
```

The administrator requires the ability to manage the API keys stored within
Vault. These secrets are maintained in a KV-V2 secrets engine enabled at the
path `external-apis`. The secret path within the engine is `socials/twitter`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Update the secret.

```shell
vault kv put \
    external-apis/socials/twitter \
    api_key=hiKD3vMecH2M6t9TTe9kZW \
    api_secret_key=XEkmqo7pc7BaRkCJZ3kwhLM8VKQBFLW7mG7KUjJTyz
```{{execute}}

## As the application

The policies defined for `admins` do not grant it the capability to perform this
operation.

Login with the `admins` user.

```shell
vault login -method=userpass \
  username=admins \
  password=admins-password
```{{execute}}

Fail to update the secret.

```shell
vault kv put \
    external-apis/socials/twitter \
    api_key=hiKD3vMecH2M6t9TTe9kZW \
    api_secret_key=XEkmqo7pc7BaRkCJZ3kwhLM8VKQBFLW7mG7KUjJTyz
```{{execute}}

It is time to discover how to write a policy to meet this requirement.

## Discover the policy change required

Login with the `root` user.

```shell
vault login root
```{{execute}}

#### 1️⃣ with the CLI flags

The `vault` CLI communicates direclty with Vault. It can optionally output a
`curl` command equivalent of its operation with `-output-curl-string`.

#### 2️⃣ with the audit logs

The audit log maintains a list of all requests handled by Vault. The last
command executed is recorded as the last object `cat log/vault_audit.log | jq -s
".[-1].request.path,.[-1].request.operation"`.

### 3️⃣ with the API docs

Select the KV-V2 API tab to view the [KV-V2 API
documentation](https://www.vaultproject.io/api-docs/secret/kv/kv-v2).

## Enact the policy

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `admins-policy`.
3. Test the policy with  the `admins` user.
