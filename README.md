
## Prerequisites

- Digital Ocean account
- Generate terraform personal access token from https://cloud.digitalocean.com/account/api/tokens

export DO_PAT="your_personal_access_token" # Can be added to ~/.zshrc

- terraform
- ansible
- credentials (SSH key from user use for login &)

## Terraform

1. Spin up server in cloud
2. Configure gateway (subdomain, gateway firewall if available) & get IP

## Ansible

3. Install tailscale
4. Install dev env stuff & dependencies (docker, nvim, etc)


## @TODO

- use cloudflare to manage DNS records for evren.co.uk
- 
