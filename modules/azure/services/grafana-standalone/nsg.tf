resource "azurerm_network_security_group" "gl-nsg" {
  name                = "gl-nsg"
  location            = azurerm_resource_group.gl-resource-group.location
  resource_group_name = azurerm_resource_group.gl-resource-group.name


  #Add rule for Inbound Access
  security_rule {
    name                       = "primary"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = var.web_access_port_range # Referenced SSH Port 22 and tcp 80 from vars.tf file.
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


#Connect NSG to Subnet
resource "azurerm_subnet_network_security_group_association" "gl-nsg-assoc" {
  subnet_id                 = azurerm_subnet.primary-subnet.id
  network_security_group_id = azurerm_network_security_group.gl-nsg.id
}