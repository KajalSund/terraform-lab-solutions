# modules/network/main.tf

resource "azurerm_virtual_network" "network_vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "network_subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.network_vnet.name
  address_prefixes     = [var.subnet1_address]
}

resource "azurerm_subnet" "network_subnet2" {
  name                 = var.subnet2_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.network_vnet.name
  address_prefixes     = [var.subnet2_address]
}

resource "azurerm_network_security_group" "network_nsg1" {
  name                = var.nsg1_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
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
    name                       = "HTTP"
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

resource "azurerm_network_security_group" "network_nsg2" {
  name                = var.nsg2_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "RDP"
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
    name                       = "WinRM"
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

# Associate Linux NSG with Linux Subnet
resource "azurerm_subnet_network_security_group_association" "linux_nsg_assoc" {
  subnet_id                 = azurerm_subnet.network_subnet1.id
  network_security_group_id = azurerm_network_security_group.network_nsg1.id
}

# Associate Windows NSG with Windows Subnet
resource "azurerm_subnet_network_security_group_association" "windows_nsg_assoc" {
  subnet_id                 = azurerm_subnet.network_subnet2.id
  network_security_group_id = azurerm_network_security_group.network_nsg2.id
}
