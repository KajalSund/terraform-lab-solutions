resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs
  location                     = azurerm_resource_group.network_rg.location
  resource_group_name          = azurerm_resource_group.network_rg.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true

  tags = local.common_tags
}

resource "azurerm_public_ip" "linux_pip" {
  count               = var.nb_count
  name                = "${var.linux_name}-${count.index + 1}-pip"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = "${var.linux_name}-${count.index + 1}"

  tags = local.common_tags
}

resource "azurerm_network_interface" "linux_nic" {
  count               = var.nb_count
  name                = "${var.linux_name}-${count.index + 1}-nic"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name

  ip_configuration {
    name                          = "${var.linux_name}-${count.index + 1}-ipconfig"
    subnet_id                     = azurerm_subnet.network_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[count.index].id
  }

  tags = local.common_tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.nb_count
  name                = "${var.linux_name}-${count.index + 1}"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  network_interface_ids = [
    azurerm_network_interface.linux_nic[count.index].id
  ]
  size                = var.linux_vm_size
  admin_username      = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_ssh_public_key)
  }

  os_disk {
    name                 = "${var.linux_name}-${count.index + 1}-os-disk"
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

  computer_name        = "${var.linux_name}-${count.index + 1}"
  availability_set_id  = azurerm_availability_set.linux_avs.id
  provision_vm_agent   = true

  tags = local.common_tags
}


