module "resource-group" {
  source                  = "./resource-group"
  resource_group_name     = format("%s-%s-resource-group", var.environment, var.name)
  resource_group_location = var.resource_group_location
}

module "vnet" {
  depends_on           = [module.resource-group]
  source               = "./vnet"
  resource_group_name  = module.resource-group.resource_group_name
  vnet_name            = format("%s-%s-vnet", var.environment, var.name)
  vnet_location        = var.resource_group_location
  address_space        = var.address_space
  ddos_protection_plan = var.ddos_protection_plan
  dns_servers          = var.dns_servers
  bgp_community        = var.bgp_community
}

module "routetable_public" {
  source                        = "./routetable"
  depends_on                    = [module.resource-group]
  resource_group_name           = module.resource-group.resource_group_name
  resource_group_location       = var.resource_group_location
  route_prefixes                = var.route_prefixes_public
  route_nexthop_types           = var.route_nexthop_types_public
  route_names                   = var.route_names_public
  route_table_name              = format("%s-%s-route-table-public", var.environment, var.name)
  disable_bgp_route_propagation = var.disable_bgp_route_propagation_public
}

module "routetable_private" {
  source                        = "./routetable"
  depends_on                    = [module.resource-group]
  resource_group_name           = module.resource-group.resource_group_name
  resource_group_location       = var.resource_group_location
  route_prefixes                = var.route_prefixes_private
  route_nexthop_types           = var.route_nexthop_types_private
  route_names                   = var.route_names_private
  route_table_name              = format("%s-%s-route-table-private", var.environment, var.name)
  disable_bgp_route_propagation = var.disable_bgp_route_propagation_private
}

module "public_subnets" {
  source                                                = "./subnets"
  depends_on                                            = [module.routetable_public]
  address_subnets                                       = var.address_subnets_public
  subnet_names                                          = var.subnet_names_public
  resource_group_name                                   = module.resource-group.resource_group_name
  virtual_network_name                                  = module.vnet.vnet_name
  route_table_id                                        = module.routetable_public.routetable_id
  network_securitygroup_id                              = module.network-security-group.network_security_group_id
  subnet_enforce_private_link_service_network_policies  = var.subnet_enforce_private_link_service_network_policies_public
  subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies_public
  subnet_delegation                                     = var.subnet_delegation_public
  subnet_service_endpoints                              = var.subnet_service_endpoints_public
}

# module "private_subnets" {
#   source                                                = "./subnets"
#   depends_on                                            = [module.routetable_private]
#   address_subnets                                       = var.address_subnets_private
#   subnet_names                                          = var.subnet_names_private
#   resource_group_name                                   = var.resource_group_name
#   virtual_network_name                                  = var.vnet_name
#   route_table_id                                        = module.routetable_private.routetable_id
#   network_securitygroup_id                              = module.network-security-group.network_security_group_id
#   subnet_enforce_private_link_service_network_policies  = var.subnet_enforce_private_link_service_network_policies_private
#   subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies_private
#   subnet_delegation                                     = var.subnet_delegation_private
#   subnet_service_endpoints                              = var.subnet_service_endpoints_private
# }

module "network-security-group" {
  depends_on            = [module.resource-group]
  source                = "Azure/network-security-group/azurerm"
  version               = "4.1.0"
  resource_group_name   = module.resource-group.resource_group_name
  security_group_name   = format("%s-%s-nsg", var.environment, var.name)
  source_address_prefix = [join("", var.address_space)]
}

# module "nat_gateway" {
#   source                      = "./nat-gateway"
#   depends_on                  = [module.private_subnets]
#   subnet_ids                  = module.private_subnets.subnet_id
#   location                    = var.resource_group_location
#   resource_group_name         = var.resource_group_name
#   public_ip_domain_name_label = var.public_ip_domain_name_label
#   public_ip_reverse_fqdn      = var.public_ip_reverse_fqdn
#   create_public_ip            = var.create_public_ip
#   public_ip_zones             = var.public_ip_zones
#   public_ip_ids               = var.public_ip_ids
#   nat_gateway_idle_timeout    = var.nat_gateway_idle_timeout
# }