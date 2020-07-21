VAULT_ADDR=http://0.0.0.0:8200
vault login root

vault read -format json secret/data/devwebapp/config
secretRead=$?

if [[ $secretRead -eq 0 ]]
then
  echo "done"
  exit 0
else
  echo "Vault is not running with secret"
  exit 1
fi


