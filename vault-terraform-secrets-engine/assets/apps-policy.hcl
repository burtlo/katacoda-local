# Get credentials from the terraform secrets engine
path "terraform/creds/my-user" {
  capabilities = [ "read" ]
}
