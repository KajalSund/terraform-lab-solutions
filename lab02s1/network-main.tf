provider "azurerm" {
  features {}
  
}

# a. Define a resource group
resource "azurerm_resource_group" "network_rg" {
  name     = "network-rg"
  location = "East US"
}

# b. Define a virtual network
resource "azurerm_virtual_network" "network_vnet" {
  name                = "network-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
}

# c. Define a subnet
resource "azurerm_subnet" "network_subnet1" {
  name                 = "network-subnet1"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.network_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# d. Define a network security group with two inbound rules
resource "azurerm_network_security_group" "network_nsg1" {
  name                = "network-nsg1"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# e. Associate NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.network_subnet1.id
  network_security_group_id = azurerm_network_security_group.network_nsg1.id
}

# 18. Add another subnet network-subnet2
resource "azurerm_subnet" "network_subnet2" {
  name                 = "network-subnet2"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.network_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 19. Define network security group network-nsg2 with inbound rules for ports 3389 and 5985
resource "azurerm_network_security_group" "network_nsg2" {
  name                = "network-nsg2"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# 20. Associate network-nsg2 with network-subnet2
resource "azurerm_subnet_network_security_group_association" "network_subnet2_nsg" {
  subnet_id                 = azurerm_subnet.network_subnet2.id
  network_security_group_id = azurerm_network_security_group.network_nsg2.id
}
