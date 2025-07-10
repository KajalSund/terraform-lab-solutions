locals {
  common_tags = {
    Name        = "Terraform-Class"
    Project     = "Learning"
    Owner       = "n01737472@humber.ca"
    Environment = "Lab"
  }
}

variable "linux_name" {
  description = "Name of the Linux virtual machine"
  type        = string
  default     = "n01737472-u-vm1"
}

variable "linux_vm_size" {
  description = "Size of the Linux virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the Linux virtual machine"
  type        = string
  default     = "n01737472"
}

variable "admin_ssh_public_key" {
  description = "Path to the SSH public key"
  type        = string
  default     = "/Users/n01737472/.ssh/id_rsa_azure.pub"
}

# OS Disk Attributes
variable "os_disk_storage_account_type" {
  description = "Storage account type for the OS disk"
  type        = string
  default     = "Premium_LRS"
}

variable "os_disk_size_gb" {
  description = "Disk size in GB for the OS disk"
  type        = number
  default     = 32
}

variable "os_disk_caching" {
  description = "Caching mode for the OS disk"
  type        = string
  default     = "ReadWrite"
}

# Ubuntu OS Image Info
variable "os_publisher" {
  description = "Publisher of the Ubuntu OS image"
  type        = string
  default     = "Canonical"
}

variable "os_offer" {
  description = "Offer of the Ubuntu OS image"
  type        = string
  default     = "UbuntuServer"
}

variable "os_sku" {
  description = "SKU of the Ubuntu OS image"
  type        = string
  default     = "18.04-DAILY-LTS"
}

variable "os_version" {
  description = "Version of the Ubuntu OS image"
  type        = string
  default     = "latest"
}

