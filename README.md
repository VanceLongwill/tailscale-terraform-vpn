
## Prerequisites

- Digital Ocean account
- Tailscale account
- terraform CLI
- ansible CLI

1. Install tailscale ansible package
   ```shell
   ansible-galaxy install artis3n.tailscale
   ```
2. Generate a tailscale auth key at https://login.tailscale.com/admin/settings/authkeys then encrypt it with ansible vault
   ```shell
   ansible-vault encrypt_string <your-auth-key-here>
   ```
3. Generate terraform personal access token from https://cloud.digitalocean.com/account/api/tokens, then save it in your environment.
   ```shell
   export DO_PAT="<your-token-here>"
   ```
4. Add your public SSH key https://cloud.digitalocean.com/account/security and make sure the name matches that supplied in `./terraform/provider.tf` i.e. `personal` unless you change it
5. Run terraform to create the server and run the ansible playbook
   ```shell
terraform apply \
  -var "do_token=${DO_PAT}" \
  -var "pvt_key=$HOME/.ssh/id_rsa"
   ```
