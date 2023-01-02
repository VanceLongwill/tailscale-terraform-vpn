variable "do_token" {
  type        = string
  sensitive   = true
  description = "Your DigitalOcean personal access token"
}

variable "tailscale_authkey" {
  type        = string
  sensitive   = true
  description = "Tailscale auth key allowing the droplet to join your tailnet"
}

variable "ssh_key_name" {
  type        = string
  default     = "personal"
  description = "The name of the DigitalOcean ssh key that will be granted SSH access to the droplet"
}

variable "pvt_key" {
  type        = string
  description = "Path to the SSH private key that will be used to connect to the instance, this should match the key refered to by the `ssh_key_name` variable"
}

variable "user" {
  type    = string
  default = "root"
}

variable "instance_name" {
  type        = string
  default     = "ubi"
  description = "A name for the droplet"
}

variable "region" {
  type        = string
  description = "The DigitalOcean region where the droplet will be created"
  default     = "lon1"
}
