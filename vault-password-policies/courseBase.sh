# Run RabbitMQ in docker with:
#   - standard HTTP admin management enabled
#   - standard HTTP port
#   - user named 'learn_vault'
#   - password 'hashicorp'

docker run --rm --name some-rabbit -p 15672:15672 \
    -e RABBITMQ_DEFAULT_USER=learn_vault \
    -e RABBITMQ_DEFAULT_PASS=hashicorp \
    rabbitmq:3-management

# Vault: install custom-built Vault 1.5 binary
wget https://lynn-vault-binaries.s3.us-east-2.amazonaws.com/vault
sudo mv ./vault /usr/local/bin/vault
sudo chmod a+x /usr/local/bin/vault