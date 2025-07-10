resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true

  tags = {
    environment = "lab07"
  }
}

resource "azurerm_public_ip" "windows_pip" {
  for_each            = var.windows_vms
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = "${each.key}-${var.dns_suffix}"

  tags = {
    environment = "lab07"
  }
}

resource "azurerm_network_interface" "windows_nic" {
  for_each            = var.windows_vms
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip[each.key].id
  }

  tags = {
    environment = "lab07"
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each            = var.windows_vms
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = each.value
  availability_set_id = azurerm_availability_set.windows_avs.id
  network_interface_ids = [
    azurerm_network_interface.windows_nic[each.key].id
  ]

  admin_username = var.admin_username
  admin_password = var.admin_password

  os_disk {
    name                 = "${each.key}-osdisk"
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  winrm_listener {
    protocol = "Http"
  }

  tags = {
    environment = "lab07"
  }
}
