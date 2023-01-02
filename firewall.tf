# Firewall that blocks all inbound traffic except https for tailscale, outbound traffic is allowed
resource "digitalocean_firewall" "only-tailscale" {
  name = "only-tailscale-${var.instance_name}"

  droplet_ids = [digitalocean_droplet.ubi.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Tailscale must be installed & up before we block outside access
  depends_on = [null_resource.ansible]
}
