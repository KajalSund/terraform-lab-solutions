module "resource_groups" {
  source             = "./modules/resource_group"
  networking_rg_name = "rg-network"
  linux_rg_name      = "rg-linux"
  windows_rg_name    = "rg-windows"
  location           = "eastus"
}

module "network" {
  source              = "./modules/network"
  vnet_name           = "lab06-vnet"
  vnet_address_space  = "10.0.0.0/16"
  subnet1_name        = "subnet-linux"
  subnet1_address     = "10.0.1.0/24"
  subnet2_name        = "subnet-windows"
  subnet2_address     = "10.0.2.0/24"
  nsg1_name           = "nsg-linux"
  nsg2_name           = "nsg-windows"
  location            = module.resource_groups.networking_rg_location
  resource_group_name = module.resource_groups.networking_rg_name
}

module "linux_vms" {
  source                    = "./modules/linux"
  linux_name                = "linuxvm"
  linux_vm_size             = "Standard_B1s"
  nb_count                  = 2
  linux_avs                 = "linux_avset"
  location                  = module.resource_groups.linux_rg_location
  resource_group_name       = module.resource_groups.linux_rg_name
  admin_username            = "azureuser"
  admin_ssh_public_key      = "~/.ssh/id_rsa_azure.pub"
  admin_ssh_private_key     = "~/.ssh/id_rsa_azure"
  subnet_id                 = module.network.subnet1_id

  os_disk_caching           = "ReadWrite"
  os_disk_storage_account_type = "Standard_LRS"
  os_disk_size_gb           = 30

  os_publisher              = "Canonical"
  os_offer                  = "UbuntuServer"
  os_sku                    = "18.04-LTS"
  os_version                = "latest"
}

module "windows_vms" {
  source              = "./modules/windows"
  location            = module.resource_groups.windows_rg_location
  resource_group_name = module.resource_groups.windows_rg_name
  subnet_id           = module.network.subnet2_id
  windows_avs         = "windows_avset"
  windows_vms         = {
    "winvm-1" = "Standard_B2s"
    "winvm-2" = "Standard_B2s"
  }
  admin_username      = "azureadmin"
  admin_password      = "kajal-n01737472"
  dns_suffix          = "n01737472"

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 127
  }

  image = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
