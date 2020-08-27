(**Persona:** app)

Run the application with the address of the Vault server, the transit key, and the generated token.

```shell
VAULT_TOKEN=$APP_TOKEN \
  VAULT_ADDR=$VAULT_ADDR \
  VAULT_TRANSIT_KEY=my_app_key \
  SHOULD_SEED_USERS=true \
  dotnet run
```{{execute}}

Connect to the database with the root credentials.

```shell
docker exec -it mysql-rewrap mysql -uroot -proot
```{{execute}}

Connect to the `my_app` table.

```shell
CONNECT my_app;
```{{execute}}


Display 10 rows from the `user_data` table where the city starts with a Vault
transit key.

```shell
SELECT * FROM user_data WHERE city LIKE "vault:v1%" limit 10;
```{{execute}}

The results display 10 rows that match this query.

Drop the connection to the database.

```shell
exit
```{{execute}}