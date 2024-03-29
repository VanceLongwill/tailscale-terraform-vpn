# Tailscale exit node VPN with terraform & ansible

Terraform module to spin up a digital ocean droplet & install tailscale in a single command :tada:

The resulting droplet is enabled as an exit node which can be used as a VPN.

Features:
- [x] Single idempotent command
- [x] Support for multiple configurations
- [x] Firewall blocking all inbound traffic except https & icmp for tailscale

How it works:

1. Terraform creates droplet
2. Terraform runs ansible playbook to install & enable tailscale via SSH
3. Terraform creates firewall to prevent further non-tailscale access.

## Prerequisites

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
2. Generate DigitalOcean personal access token at https://cloud.digitalocean.com/account/api/tokens
3. Add your public SSH key https://cloud.digitalocean.com/account/security and make sure the name matches that supplied in the `ssh_key_name` terraform arg (defaults to `personal`)
4. Create a `main.tf` and import the module (see [variables.tf](./variables.tf) for all available options). For example: 
   ```terraform
   variable "do_token" {
     sensitive = true
   }

   variable "tailscale_authkey" {
     sensitive = true
   }

   module "vpn" {
     source = "github.com/VanceLongwill/tailscale-terraform-vpn"

     region            = "lon1"
     instance_name     = "my-vpn"
     ssh_key_name      = "personal"
     ssh_private_key   = "~/.ssh/id_ed25519" 
     tailscale_authkey = var.tailscale_authkey
     do_token          = var.do_token
   }
   ```
5. Run `terraform init`
6. Run terraform to create the server and run the ansible playbook
   ```shell
   terraform apply \
     -var "do_token=<your-digital-ocean-access-token-here>" \
     -var "tailscale_authkey=<your-tailscale-authkey-here>"
   ```
