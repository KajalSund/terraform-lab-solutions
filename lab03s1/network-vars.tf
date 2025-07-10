variable "resource_group_name" {
  type    = string
  default = "network-rg"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "vnet_name" {
  type    = string
  default = "network-vnet"
}

variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet1_name" {
  type    = string
  default = "network-subnet1"
}

variable "subnet2_name" {
  type    = string
  default = "network-subnet2"
}

variable "subnet1_address" {
  type    = string
  default = "10.0.0.0/24"
}

variable "subnet2_address" {
  type    = string
  default = "10.0.1.0/24"
}

variable "nsg1_name" {
  type    = string
  default = "network-nsg1"
}

variable "nsg2_name" {
  type    = string
  default = "network-nsg2"
}

