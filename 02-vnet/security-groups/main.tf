resource "azurerm_network_security_group" "network_sg" {
  count = length(var.subnet_prefixes)

  name                = format("%s-%s", var.subnet_names[count.index], "network-sg")
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  security_rule {
    name                       = format("%s-%s", var.subnet_names[count.index], "network-sg-rule-inbound")
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.source_address_prefix
    destination_address_prefix = var.source_address_prefix
  }

  security_rule {
    name                       = format("%s-%s", var.subnet_names[count.index], "network-sg-rule-outbound")
    priority                   = 102
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "0.0.0.0/0"
  }

  tags = {
    "Name" = format("%s-%s", var.subnet_names[count.index], "network-sg")
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_network_sg_association" {
  count = length(var.subnet_prefixes)

  network_security_group_id = element(azurerm_network_security_group.network_sg.*.id, count.index)
  subnet_id                 = element(var.vnet_subnets, count.index)
}
resource "azurerm_route_table" "subnet_rt" {
  count = length(var.subnet_prefixes)

  name                          = format("%s-%s", var.subnet_names[count.index], "route-table")
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  disable_bgp_route_propagation = false

  route {
    name           = format("%s-%s", var.subnet_names[count.index], "route")
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  tags = {
    "Name" = format("%s-%s", var.subnet_names[count.index], "route-table")
  }
}

resource "azurerm_subnet_route_table_association" "subnet_rt_association" {
  count = length(var.subnet_prefixes)

  route_table_id = element(azurerm_route_table.subnet_rt.*.id, count.index)
  subnet_id      = element(var.vnet_subnets, count.index)
}

output "subnet_id" {
  description = "Subnet ID"
  value       = azurerm_subnet_network_security_group_association.subnet_network_sg_association.*.id 
}