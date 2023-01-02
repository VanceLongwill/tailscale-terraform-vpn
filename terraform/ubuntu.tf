resource "digitalocean_droplet" "ubi" {
  image  = "ubuntu-20-04-x64"
  name   = "ubi"
  region = "lon1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
}

output "ip_address" {
  value = digitalocean_droplet.ubi.ipv4_address
}

resource "null_resource" "ansible" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = digitalocean_droplet.ubi.ipv4_address
      user = var.user
      private_key = file(var.pvt_key)
      timeout = "2m"
    }

    inline = ["echo 'connected!'"]
  }

  provisioner "local-exec" {
    command = "TAILSCALE_KEY=${var.tailscale_authkey} ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.user} -i '${digitalocean_droplet.ubi.ipv4_address},' --private-key ${var.pvt_key} ../ansible/playbook.yaml"
  }

  depends_on = [digitalocean_droplet.ubi]
}

