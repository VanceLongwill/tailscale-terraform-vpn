
## Prerequisites

- Digital Ocean account
- Tailscale account
- terraform CLI installed
- ansible CLI installed

### Exit node approval

Auto approve: https://tailscale.com/kb/1018/acls/#auto-approvers-for-routes-and-exit-nodes

**or**

Login into the tailscale web console and enable the exit node manually

## Steps

1. Install tailscale ansible package
   ```shell
   ansible-galaxy install artis3n.tailscale
   ```
2. Generate a tailscale auth key at https://login.tailscale.com/admin/settings/authkeys
3. Generate terraform personal access token from https://cloud.digitalocean.com/account/api/tokens
4. Add your public SSH key https://cloud.digitalocean.com/account/security and make sure the name matches that supplied in the `ssh_key_name` terraform arg (defaults to `m1`)
5. Navigate to the [terraform](./terraform) dir `cd terraform`
6. Run `terraform init` (if you haven't already)
7. Run terraform to create the server and run the ansible playbook
   ```shell
terraform apply \
  -var "do_token=$YOUR_DIGITAL_OCEAN_ACCESS_KEY" \
  -var "tailscale_authkey=$YOUR_TAILSCALE_AUTHKEY" \
  -var "pvt_key=$HOME/.ssh/id_ed25519" \
  -var "ssh_key_name=m1" \
  -var "instance_name=vpn" \
  -var "region=lon1"
   ```
