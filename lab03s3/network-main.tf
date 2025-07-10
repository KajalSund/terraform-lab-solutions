# a. Define a resource group
resource "azurerm_resource_group" "network_rg" {
  name     = var.resource_group_name
  location = var.location
}

# b. Define a virtual network
resource "azurerm_virtual_network" "network_vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# c. Define a subnet
resource "azurerm_subnet" "network_subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet1_address]
}

# d. Define a network security group (NSG1)
resource "azurerm_network_security_group" "network_nsg1" {
  name                = var.nsg1_name
  location            = var.location
  resource_group_name = var.resource_group_name

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

# e. Associate NSG with subnet1
resource "azurerm_subnet_network_security_group_association" "nsg_association1" {
  subnet_id                 = azurerm_subnet.network_subnet1.id
  network_security_group_id = azurerm_network_security_group.network_nsg1.id
}

# f. Define subnet2
resource "azurerm_subnet" "network_subnet2" {
  name                 = var.subnet2_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet2_address]
}

# g. Define a second network security group (NSG2)
resource "azurerm_network_security_group" "network_nsg2" {
  name                = var.nsg2_name
  location            = var.location
  resource_group_name = var.resource_group_name

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

# h. Associate NSG2 with subnet2
resource "azurerm_subnet_network_security_group_association" "nsg_association2" {
  subnet_id                 = azurerm_subnet.network_subnet2.id
  network_security_group_id = azurerm_network_security_group.network_nsg2.id
}
