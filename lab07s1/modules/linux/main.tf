resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
}

resource "azurerm_public_ip" "linux_pip" {
  count               = var.nb_count
  name                = "${var.linux_name}-${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = "${var.linux_name}-${count.index + 1}-n01737472"
}

resource "azurerm_network_interface" "linux_nic" {
  count               = var.nb_count
  name                = "${var.linux_name}-${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.linux_name}-${count.index + 1}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[count.index].id
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.nb_count
  name                = "${var.linux_name}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [
    azurerm_network_interface.linux_nic[count.index].id
  ]
  size                            = var.linux_vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_ssh_public_key)
  }

  os_disk {
    name                 = "${var.linux_name}-${count.index + 1}-osdisk"
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

  availability_set_id = azurerm_availability_set.linux_avs.id
  computer_name       = "${var.linux_name}-${count.index + 1}"
  provision_vm_agent  = true
}
