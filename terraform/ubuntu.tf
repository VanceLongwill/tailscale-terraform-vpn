resource "digitalocean_droplet" "ubi" {
  image = "ubuntu-20-04-x64"
  name = "ubi"
  region = "lon1"
  size = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host = self.ipv4_address
    user = var.user
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.user} -i '${self.ipv4_address},' --private-key ${var.pvt_key} ../ansible/playbook.yaml --ask-vault-pass"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     #"export PATH=$PATH:/usr/bin",
  #     # install nginx
  #     # "sudo apt update",
  #     # "sudo apt install -y nginx"
  #   ]
  # }
}

resource "null_resource" "ansible" {
  
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.user} -i '${digitalocean_droplet.ubi.ipv4_address},' --private-key ${var.pvt_key} ../ansible/playbook.yaml --ask-vault-pass"
  }

  depends_on = [digitalocean_droplet.ubi]
}

