output "availability_set_name" {
  value = azurerm_availability_set.linux_avs.name
}

output "linux_vm_names" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.name]
}

output "linux_private_ips" {
  value = [for nic in azurerm_network_interface.linux_nic : nic.ip_configuration[0].private_ip_address]
}

output "linux_public_ips" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.ip_address]
}

output "linux_fqdns" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.fqdn]
}
