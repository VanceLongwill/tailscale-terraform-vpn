## Prerequisites

- Digital Ocean account
- Tailscale account
- terraform CLI installed
- ansible CLI installed
- Install the unofficial tailscale ansible package
   ```shell
   ansible-galaxy install artis3n.tailscale
   ```
   
### Exit node approval

Auto approve: https://tailscale.com/kb/1018/acls/#auto-approvers-for-routes-and-exit-nodes

**or**

Login into the tailscale web console and enable the exit node manually (after creation).

## Steps

1. Generate a tailscale auth key at https://login.tailscale.com/admin/settings/authkeys
2. Generate terraform personal access token from https://cloud.digitalocean.com/account/api/tokens
3. Add your public SSH key https://cloud.digitalocean.com/account/security and make sure the name matches that supplied in the `ssh_key_name` terraform arg (defaults to `m1`)
4. Navigate to the [vpn](./vpn) dir `cd vpn` (or another dir if you're using this as a module)
5. Run `terraform init` if you haven't already
6. Run terraform to create the server and run the ansible playbook
   ```shell
terraform apply \
  -var "do_token=$YOUR_DIGITAL_OCEAN_ACCESS_KEY" \
  -var "tailscale_authkey=$YOUR_TAILSCALE_AUTHKEY" \
  -var "pvt_key=~/.ssh/id_ed25519" \
  -var "ssh_key_name=m1" \
  -var "instance_name=vpn" \
  -var "region=lon1"
   ```

### Managing multiple droplets/configs

The `vpn` dir can also be imported as a module to manage multiple configs/state

#### Example: 

```terraform
variable "do_token" {
  sensitive = true
}

variable "tailscale_authkey" {
  sensitive = true
}

module "vpn" {
  source = "../vpn"

  region            = "lon1"
  instance_name     = "lon1"
  tailscale_authkey = var.tailscale_authkey
  do_token          = var.do_token
  pvt_key           = "~/.ssh/id_ed25519"
}
```
