
## Prerequisites

- Digital Ocean account
- Generate terraform personal access token from https://cloud.digitalocean.com/account/api/tokens

```shell
export DO_PAT="<your-token-here>"
```

- terraform
- ansible
- credentials (SSH key from user use for login &)

## Terraform

1. Spin up server in cloud 
   ```shell
terraform apply \
  -var "do_token=${DO_PAT}" \
  -var "pvt_key=$HOME/.ssh/id_rsa"
   ```
2. Configure gateway (subdomain, gateway firewall if available) & get IP

## Ansible

3. Install tailscale
4. Install dev env stuff & dependencies (docker, nvim, etc)


## @TODO

- use cloudflare to manage DNS records for evren.co.uk
- 
