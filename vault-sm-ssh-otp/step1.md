Download the `vault-ssh-helper`.

```shell-session
wget https://releases.hashicorp.com/vault-ssh-helper/0.1.4/vault-ssh-helper_0.1.4_linux_amd64.zip
```

Unzip the vault-ssh-helper in `/usr/local/bin`.

```shell-session
sudo unzip -q vault-ssh-helper_0.1.4_linux_amd64.zip -d /usr/local/bin
```

Make sure that `vault-ssh-helper` is executable.

```shell-session
sudo chmod 0755 /usr/local/bin/vault-ssh-helper
```

Set the usr and group of `vault-ssh-helper` to `root`.

```shell-session
sudo chown root:root /usr/local/bin/vault-ssh-helper
```


Create a new directory for `vault-ssh-helper`.

```shell-session
sudo mkdir /etc/vault-ssh-helper.d/
```

Create the config file.

```shell-session
sudo tee /etc/vault-ssh-helper.d/config.hcl <<EOF
vault_addr = "http://198.51.100.10:8200"
ssh_mount_point = "ssh"
ca_cert = "-dev"
tls_skip_verify = false
allowed_roles = "*"
EOF
```


sudo cp /etc/pam.d/sshd /etc/pam.d/sshd.orig

```shell-session
sudo sed -i 's/@include common-auth/# @include common-auth/' /etc/pam.d/sshd
```

```shell-session
echo -e "\nauth requisite pam_exec.so quiet expose_authtok log=/var/log/vault-ssh.log /usr/local/bin/vault-ssh-helper -dev -config=/etc/vault-ssh-helper.d/config.hcl
auth optional pam_unix.so not_set_pass use_first_pass nodelay" | sudo tee -a /etc/pam.d/sshd
```

```shell-session
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
```

```
sudo sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
```

```
sudo systemctl restart sshd
```