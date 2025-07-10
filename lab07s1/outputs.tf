output "networking_rg_name" {
  value = module.resource_groups.networking_rg_name
}

output "linux_rg_name" {
  value = module.resource_groups.linux_rg_name
}

output "windows_rg_name" {
  value = module.resource_groups.windows_rg_name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "vnet_address_space" {
  value = module.network.vnet_address_space
}

output "subnet1_name" {
  value = module.network.subnet1_name
}

output "subnet2_name" {
  value = module.network.subnet2_name
}

output "nsg1_name" {
  value = module.network.nsg1_name
}

output "nsg2_name" {
  value = module.network.nsg2_name
}

output "linux_vm_names" {
  value = module.linux_vms.linux_vm_names
}

output "linux_private_ips" {
  value = module.linux_vms.linux_private_ips
}

output "linux_public_ips" {
  value = module.linux_vms.linux_public_ips
}

output "linux_fqdns" {
  value = module.linux_vms.linux_fqdns
}

output "windows_vm_names" {
  value = module.windows_vms.windows_vm_names
}

output "windows_fqdns" {
  value = module.windows_vms.windows_fqdns
}

output "windows_private_ips" {
  value = module.windows_vms.windows_private_ips
}

output "windows_public_ips" {
  value = module.windows_vms.windows_public_ips
}
