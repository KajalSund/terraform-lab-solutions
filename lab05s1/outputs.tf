output "linux_vm_names" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.name]
}

output "linux_vm_fqdns" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.fqdn]
}

output "linux_vm_private_ips" {
  value = [for nic in azurerm_network_interface.linux_nic : nic.private_ip_address]
}

output "linux_vm_public_ips" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.ip_address]
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

output "linux_availability_set_name" {
  value = azurerm_availability_set.linux_avs.name
}


