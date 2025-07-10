resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = azurerm_resource_group.network_rg.location
  resource_group_name          = azurerm_resource_group.network_rg.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true

  tags = {
    environment = "lab04"
  }
}

resource "azurerm_public_ip" "windows_pip" {
  for_each            = var.windows_name
  name                = "${each.key}-pip"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = each.key

  tags = {
    environment = "lab04"
  }
}

resource "azurerm_network_interface" "windows_nic" {
  for_each            = var.windows_name
  name                = "${each.key}-nic"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = azurerm_subnet.network_subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip[each.key].id
  }

  tags = {
    environment = "lab04"
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each            = var.windows_name
  name                = each.key
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  network_interface_ids = [
    azurerm_network_interface.windows_nic[each.key].id
  ]
  size                = each.value
  admin_username      = var.windows_admin_username
  admin_password      = var.admin_password
  availability_set_id = azurerm_availability_set.windows_avs.id
  provision_vm_agent  = true

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = var.windows_os_disk.caching
    storage_account_type = var.windows_os_disk.storage_account_type
    disk_size_gb         = var.windows_os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.windows_image.publisher
    offer     = var.windows_image.offer
    sku       = var.windows_image.sku
    version   = var.windows_image.version
  }

  winrm_listener {
    protocol = "Http"
  }

  computer_name = each.key

  tags = {
    environment = "lab04"
  }
}

