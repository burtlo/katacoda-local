sudo addgroup --system vault >/dev/null

sudo adduser \
  --system \
  --disabled-login \
  --ingroup "vault" \
  --home "/srv/vault" \
  --no-create-home \
  --gecos "HashiCorp Vault user" \
  --shell /bin/false \
  vault  >/dev/null
fi

sudo mkdir -pm 0755 /vault/storage
sudo chown -R vault:vault /vault/storage
sudo chmod -R a+rwx /vault/storage

sudo tee /etc/vault.d/vault.hcl <<EOF
storage "raft" {
  path    = "/vault/storage"
  node_id = "server"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  cluster_address     = "0.0.0.0:8201"
  tls_disable = true
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "http://127.0.0.1:8201"
disable_mlock = true
ui=true
EOF

sudo chown -R vault:vault /etc/vault.d /etc/ssl/vault
sudo chmod -R 0644 /etc/vault.d/*

sudo tee -a /etc/environment <<EOF
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_SKIP_VERIFY=true
EOF

source /etc/environment

sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault

read -d '' VAULT_SERVICE <<EOF
[Unit]
Description=Vault
Requires=network-online.target
After=network-online.target

[Service]
Restart=on-failure
PermissionsStartOnly=true
ExecStartPre=/sbin/setcap 'cap_ipc_lock=+ep' /usr/local/bin/vault
ExecStart=/usr/local/bin/vault server -config /etc/vault.d
ExecReload=/bin/kill -HUP \$MAINPID
KillSignal=SIGTERM
User=vault
Group=vault

[Install]
WantedBy=multi-user.target
EOF

SYSTEMD_DIR="/lib/systemd/system"
echo "$VAULT_SERVICE" | sudo tee $SYSTEMD_DIR/vault.service
sudo chmod 0664 $SYSTEMD_DIR/vault*

sudo systemctl enable vault
sudo systemctl start vault

sleep 5

vault operator init -key-shares 1 -key-threshold 1 -format=json > /tmp/key.json

VAULT_TOKEN=$(cat /tmp/key.json | jq -r ".root_token")
VAULT_UNSEAL_KEY=$(cat /tmp/key.json | jq -r ".unseal_keys_b64[]")

vault operator unseal $VAULT_UNSEAL_KEY
vault login $VAULT_TOKEN