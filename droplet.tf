data "digitalocean_ssh_key" "terraform" {
  name = var.ssh_key_name
}

resource "digitalocean_droplet" "ubi" {
  image  = "ubuntu-20-04-x64"
  name   = var.instance_name
  region = var.region
  size   = var.size
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

  # Wait for the droplet to be reachable via SSH
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = digitalocean_droplet.ubi.ipv4_address
      user        = var.user
      private_key = file(var.ssh_private_key)
      timeout     = "2m"
    }

    inline = ["echo 'connected!'"]
  }

  # Run the ansible playbook against the droplet
  provisioner "local-exec" {
    environment = {
      TAILSCALE_KEY             = var.tailscale_authkey
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
    command = "ansible-playbook -u ${var.user} -i '${digitalocean_droplet.ubi.ipv4_address},' --private-key ${var.ssh_private_key} ${path.module}/ansible/playbook.yaml"
  }

  depends_on = [digitalocean_droplet.ubi]
}

