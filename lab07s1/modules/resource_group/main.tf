resource "azurerm_resource_group" "networking_rg" {
  name     = var.networking_rg_name
  location = var.location
}

resource "azurerm_resource_group" "linux_rg" {
  name     = var.linux_rg_name
  location = var.location
}

resource "azurerm_resource_group" "windows_rg" {
  name     = var.windows_rg_name
  location = var.location
}
