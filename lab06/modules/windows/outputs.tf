output "windows_vm_names" {
  value = [for vm in azurerm_windows_virtual_machine.windows_vm : vm.name]
}

output "windows_private_ips" {
  value = [for nic in azurerm_network_interface.windows_nic : nic.ip_configuration[0].private_ip_address]
}

output "windows_public_ips" {
  value = [for pip in azurerm_public_ip.windows_pip : pip.ip_address]
}

output "windows_fqdns" {
  value = [for pip in azurerm_public_ip.windows_pip : pip.fqdn]
}

output "availability_set_id" {
  value = azurerm_availability_set.windows_avs.id
}
