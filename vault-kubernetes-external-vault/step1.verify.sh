VAULT_ADDR=http://0.0.0.0:8200

if [[ $(vault read -format json secret/data/devwebapp/config) ]]
then
  echo "done"
else
  echo "Vault is not running with secret"
fi


