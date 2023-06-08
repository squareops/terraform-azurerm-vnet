resource "azurerm_subnet" "subnet" {
  count =  length(var.subnet_names)

  address_prefixes                               = [var.address_subnets[count.index]]
  name                                           = var.subnet_names[count.index]
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = var.virtual_network_name
  enforce_private_link_endpoint_network_policies = lookup(var.subnet_enforce_private_link_endpoint_network_policies, var.subnet_names[count.index], false)
  enforce_private_link_service_network_policies  = lookup(var.subnet_enforce_private_link_service_network_policies, var.subnet_names[count.index], false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, var.subnet_names[count.index], null)

  dynamic "delegation" {
    for_each = lookup(var.subnet_delegation, var.subnet_names[count.index], {})

    content {
      name = delegation.key

      service_delegation {
        name    = lookup(delegation.value, "service_name")
        actions = lookup(delegation.value, "service_actions", [])
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "vnet" {
  count =  length(var.subnet_names)

  network_security_group_id = var.network_securitygroup_id
  subnet_id      = azurerm_subnet.subnet[count.index].id
}

resource "azurerm_subnet_route_table_association" "vnet" {
  count =  length(var.subnet_names)

  route_table_id = var.route_table_id 
  subnet_id      = azurerm_subnet.subnet[count.index].id
}

output "subnet_id" {
  value       = azurerm_subnet.subnet.*.id
  description = "ID of the subnet"
}