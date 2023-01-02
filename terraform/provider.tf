terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  sensitive = true
}

variable "tailscale_authkey" {
  sensitive = true
}

variable "pvt_key" {}

variable "user" {
  default = "root"
}

variable "ssh_key_name" {
  default = "m1"
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "m1"
}

variable "instance_name" {
  default = "ubi"
}

variable "region" {
  description = "Digital ocean region"
  default = "lon1"
}
