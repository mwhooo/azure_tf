# get the the resource group by name, we can use this data object
data "azurerm_resource_group" "rg" {
    name = var.rg_name
}

# Create vnet
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = [var.address_space]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# subnets
resource "azurerm_subnet" "windows_subnet" {
  name                 = var.windows_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space, var.subnet_bits, var.windows_bits)] # 8 bits on top of addrespace (/16) and last number is the actual subnet 10.0.5.0/24 in vnet example
}

resource "azurerm_subnet" "linux_subnet" {
  name                 = var.linux_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space, var.subnet_bits, var.linux_bits)] # 8 bits on top of addrespace (/16) and last number is the actual subnet 10.0.4.0/24 in vnet example
}

resource "azurerm_subnet" "storage_subnet" {
  name                 = var.storage_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space, var.subnet_bits, var.storage_bits)] # 8 bits on top of addrespace (/16) and last number is the actual subnet 10.0.4.0/24 in vnet example
}

resource "azurerm_network_security_group" "windows_nsg" {
  name                = "windows-NSG"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  security_rule {
    name                       = "Allow_RDP_for_everyone"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "linux_nsg" {
  name                = "linux-NSG"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  security_rule {
    name                       = "Allow_SSH_for_everyone"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "storage_nsg" {
  name                = "storage-NSG"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  security_rule {
    name                       = "Allow_HTTPS_for_everyone"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_subnet_network_security_group_association" "linux_nsga" {
  subnet_id                 = azurerm_subnet.linux_subnet.id
  network_security_group_id = azurerm_network_security_group.linux_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "windows_nsga" {
  subnet_id                 = azurerm_subnet.windows_subnet.id
  network_security_group_id = azurerm_network_security_group.windows_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "storage_nsga" {
  subnet_id                 = azurerm_subnet.storage_subnet.id
  network_security_group_id = azurerm_network_security_group.storage_nsg.id
}