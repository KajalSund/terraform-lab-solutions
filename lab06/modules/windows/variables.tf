variable "windows_avs" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}

variable "windows_vms" {
  description = "Map of VM names to sizes"
  type        = map(string)
}

variable "admin_username" {}
variable "admin_password" {}

variable "dns_suffix" {}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
}

variable "image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}
