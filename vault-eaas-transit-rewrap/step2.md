(**Persona:** security engineer)

Display the limited scope policy stored in `rewrap_example.hcl`.

```shell
cat rewrap_example.hcl
```{{execute}}

Create the `rewrap_example` policy.

```shell
vault policy write rewrap_example ./rewrap_example.hcl
```{{execute}}

Finally, create a token to use the `rewrap_example` policy.

```shell
vault token create -policy=rewrap_example
```{{execute}}


```shell
APP_TOKEN=$(vault token create -format=json  -policy=rewrap_example | jq -r ".data.token")
```{{execute}}

Display the token created.

```shell
echo $APP_TOKEN
```{{execute}}
