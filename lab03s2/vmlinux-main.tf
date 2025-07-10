# a. Public IP Address
resource "azurerm_public_ip" "linux_pip" {
  name                = "${var.linux_name}-pip"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = var.linux_name

  tags = local.common_tags
}


# b. Network Interface
resource "azurerm_network_interface" "linux_nic" {
  name                = "${var.linux_name}-nic"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name

  ip_configuration {
    name                          = "${var.linux_name}-ipconfig"
    subnet_id                     = azurerm_subnet.network_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip.id
  }
  
  tags = local.common_tags
}

# c. Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = var.linux_name
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  network_interface_ids = [
    azurerm_network_interface.linux_nic.id
  ]
  size                = var.linux_vm_size
  admin_username      = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_ssh_public_key)
  }

  os_disk {
    name                 = "${var.linux_name}-os-disk"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }

  computer_name  = var.linux_name
  provision_vm_agent = true

  tags = local.common_tags
}


