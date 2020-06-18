# Install Helm 3 and overwrite Helm 2
curl -LO https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
tar -xvf helm-v3.2.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/bin/

# Install a shallow copy of the secrets-store-csi-driver
git clone --depth=1 https://github.com/kubernetes-sigs/secrets-store-csi-driver.git
