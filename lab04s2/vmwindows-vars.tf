variable "windows_avs" {
  description = "Availability Set for Windows VMs"
  default     = "windows-avs"
}

variable "windows_name" {
  default = {
    n01737472-w-vm1 = "Standard_B1s"
    n01737472-w-vm2 = "Standard_B1ms"
  }
}

variable "windows_admin_username" {
  description = "Admin username for the Windows virtual machine"
  type        = string
  default     = "n01737472"
}

variable "admin_password" {
  description = "Admin password for the Windows VM"
  type        = string
  sensitive   = true
}

variable "windows_image" {
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

variable "windows_os_disk" {
  default = {
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 128
    caching              = "ReadWrite"
  }
}

