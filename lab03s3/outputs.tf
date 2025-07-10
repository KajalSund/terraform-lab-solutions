# a. VM Hostname
output "vm_hostname" {
  value = azurerm_linux_virtual_machine.linux_vm.computer_name
}

# b. VM FQDN
output "vm_fqdn" {
  value = azurerm_public_ip.linux_pip.fqdn
}

# c. Private IP Address
output "private_ip_address" {
  value = azurerm_network_interface.linux_nic.private_ip_address
}

# c. Public IP Address
output "public_ip_address" {
  value = azurerm_public_ip.linux_pip.ip_address
}

# d. Virtual Network Name
output "virtual_network_name" {
  value = azurerm_virtual_network.network_vnet.name
}

# d. Virtual Network Address Space
output "virtual_network_address_space" {
  value = azurerm_virtual_network.network_vnet.address_space
}

# e. Subnet 1 Name
output "subnet1_name" {
  value = azurerm_subnet.network_subnet1.name
}

# e. Subnet 1 Address Prefix
output "subnet1_address_prefix" {
  value = azurerm_subnet.network_subnet1.address_prefixes
}

# e. Subnet 2 Name
output "subnet2_name" {
  value = azurerm_subnet.network_subnet2.name
}

# e. Subnet 2 Address Prefix
output "subnet2_address_prefix" {
  value = azurerm_subnet.network_subnet2.address_prefixes
}

