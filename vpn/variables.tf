variable "do_token" {
  type      = string
  sensitive = true
}

variable "tailscale_authkey" {
  type      = string
  sensitive = true
}

variable "ssh_key_name" {
  type    = string
  default = "m1"
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
  type    = string
  default = "ubi"
}

variable "region" {
  type        = string
  description = "Digital ocean region"
  default     = "lon1"
}
