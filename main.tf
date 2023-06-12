locals {
  public_subnets               = var.create_public_subnets ? length(var.address_subnets_public) > 0 ? var.address_subnets_public : [for netnum in range(0, var.zones) : cidrsubnet(var.address_space, 8, netnum)] : []
  private_subnets              = var.create_private_subnets ? length(var.address_subnets_private) > 0 ? var.address_subnets_private : [for netnum in range(var.zones, var.zones * 2) : cidrsubnet(var.address_space, 4, netnum)] : []
  database_subnets             = var.create_database_subnets ? length(var.address_subnets_database) > 0 ? var.address_subnets_database : [for netnum in range(var.zones * 2, var.zones * 3) : cidrsubnet(var.address_space, 8, netnum)] : []
  route_prefixes_public        = var.create_public_subnets ? length(var.route_prefixes_public) > 0 ? var.route_prefixes_public : [var.address_space, "0.0.0.0/0"] : []
  route_names_public           = var.create_public_subnets ? length(var.route_names_public) > 0 ? var.route_names_public : ["Vnet", "Internet"] : []
  route_nexthop_types_public   = var.create_public_subnets ? length(var.route_nexthop_types_public) > 0 ? var.route_nexthop_types_public : ["VnetLocal", "Internet"] : []
  route_prefixes_private       = var.create_private_subnets ? length(var.route_prefixes_private) > 0 ? var.route_prefixes_private : [var.address_space] : []
  route_names_private          = var.create_private_subnets ? length(var.route_names_private) > 0 ? var.route_names_private : ["Vnet"] : []
  route_nexthop_types_private  = var.create_private_subnets ? length(var.route_nexthop_types_private) > 0 ? var.route_nexthop_types_private : ["VnetLocal"] : []
  route_prefixes_database      = var.create_database_subnets ? length(var.route_prefixes_database) > 0 ? var.route_prefixes_database : [var.address_space] : []
  route_names_database         = var.create_database_subnets ? length(var.route_names_database) > 0 ? var.route_names_database : ["Vnet"] : []
  route_nexthop_types_database = var.create_database_subnets ? length(var.route_nexthop_types_database) > 0 ? var.route_nexthop_types_database : ["VnetLocal"] : []
  subnet_names_public          = var.create_public_subnets ? length(var.subnet_names_public) > 0 ? (var.subnet_names_public) : [for index, public_subnet in local.public_subnets : format("%s-%s-public-subnet-%d", var.environment, var.name, index + 1)] : []
  subnet_names_private         = var.create_private_subnets ? length(var.subnet_names_private) > 0 ? (var.subnet_names_private) : [for index, private_subnet in local.private_subnets : format("%s-%s-private-subnet-%d", var.environment, var.name, index + 1)] : []
  subnet_names_database        = var.create_database_subnets ? length(var.subnet_names_database) > 0 ? (var.subnet_names_database) : [for index, database_subnet in local.database_subnets : format("%s-%s-database-subnet-%d", var.environment, var.name, index + 1)] : []
  additional_tags = merge(
    var.additional_tags, {
      "Name"        = var.name,
      "Environment" = var.environment
    }
  )
}

module "resource-group" {
  source                  = "./modules/resource-group"
  resource_group_name     = format("%s-%s-resource-group", var.environment, var.name)
  resource_group_location = var.resource_group_location
  tags                    = local.additional_tags
}

module "vnet" {
  count               = var.create_vnet ? 1 : 0
  source              = "Azure/vnet/azurerm"
  version             = "4.1.0"
  depends_on          = [module.resource-group]
  resource_group_name = module.resource-group.resource_group_name
  use_for_each        = true
  address_space       = [var.address_space]
  vnet_name           = format("%s-%s-vnet", var.environment, var.name)
  subnet_prefixes     = concat(local.public_subnets, local.private_subnets, local.database_subnets)
  subnet_names        = concat(local.subnet_names_public, local.subnet_names_private, local.subnet_names_database)
  vnet_location       = var.resource_group_location

  route_tables_ids = merge(
    (length(local.subnet_names_public) > 0 ? { for subnet_name in local.subnet_names_public : subnet_name => "${module.routetable_public[0].routetable_id}" } : null),
    (length(local.subnet_names_private) > 0 ? { for subnet_name in local.subnet_names_private : subnet_name => "${module.routetable_private[0].routetable_id}" } : null),
    (length(local.subnet_names_database) > 0 ? { for subnet_name in local.subnet_names_database : subnet_name => "${module.routetable_database[0].routetable_id}" } : null)
  )
  nsg_ids = merge(
    (length(local.subnet_names_public) > 0 ? { for subnet_name in local.subnet_names_public : subnet_name => "${module.network_security_group[0].network_security_group_id}" } : null),
    (length(local.subnet_names_private) > 0 ? { for subnet_name in local.subnet_names_private : subnet_name => "${module.network_security_group[0].network_security_group_id}" } : null),
    (length(local.subnet_names_database) > 0 ? { for subnet_name in local.subnet_names_database : subnet_name => "${module.network_security_group[0].network_security_group_id}" } : null)
  )
  tags = local.additional_tags

}

module "routetable_public" {
  count                         = var.create_public_subnets ? 1 : 0
  source                        = "./modules/routetable"
  depends_on                    = [module.resource-group]
  resource_group_name           = module.resource-group.resource_group_name
  resource_group_location       = var.resource_group_location
  route_prefixes                = local.route_prefixes_public
  route_nexthop_types           = local.route_nexthop_types_public
  route_names                   = local.route_names_public
  route_table_name              = format("%s-%s-route-table-public", var.environment, var.name)
  disable_bgp_route_propagation = var.disable_bgp_route_propagation_public
  tags                          = local.additional_tags
}

module "routetable_private" {
  count                         = var.create_private_subnets ? 1 : 0
  source                        = "./modules/routetable"
  depends_on                    = [module.resource-group]
  resource_group_name           = module.resource-group.resource_group_name
  resource_group_location       = var.resource_group_location
  route_prefixes                = local.route_prefixes_private
  route_nexthop_types           = local.route_nexthop_types_private
  route_names                   = local.route_names_private
  route_table_name              = format("%s-%s-route-table-private", var.environment, var.name)
  disable_bgp_route_propagation = var.disable_bgp_route_propagation_private
  tags                          = local.additional_tags
}

module "routetable_database" {
  count                         = var.create_database_subnets ? 1 : 0
  source                        = "./modules/routetable"
  depends_on                    = [module.resource-group]
  resource_group_name           = module.resource-group.resource_group_name
  resource_group_location       = var.resource_group_location
  route_prefixes                = local.route_prefixes_database
  route_nexthop_types           = local.route_nexthop_types_database
  route_names                   = local.route_names_database
  route_table_name              = format("%s-%s-route-table-database", var.environment, var.name)
  disable_bgp_route_propagation = var.disable_bgp_route_propagation_database
  tags                          = local.additional_tags
}

module "network_security_group" {
  count                 = var.create_network_security_group ? 1 : 0
  depends_on            = [module.resource-group]
  source                = "Azure/network-security-group/azurerm"
  version               = "4.1.0"
  resource_group_name   = module.resource-group.resource_group_name
  security_group_name   = format("%s-%s-nsg", var.environment, var.name)
  source_address_prefix = [var.address_space]
  tags                  = local.additional_tags
}

module "nat_gateway" {
  count                       = var.create_nat_gateway ? 1 : 0
  source                      = "./modules/nat-gateway"
  depends_on                  = [module.vnet]
  name                        = format("%s-%s-nat", var.environment, var.name)
  subnet_ids                  = slice(module.vnet[0].vnet_subnets, 0, (length(module.vnet[0].vnet_subnets) - (length(local.public_subnets))))
  location                    = var.resource_group_location
  resource_group_name         = module.resource-group.resource_group_name
  public_ip_domain_name_label = var.public_ip_domain_name_label
  public_ip_reverse_fqdn      = var.public_ip_reverse_fqdn
  create_public_ip            = var.create_public_ip
  public_ip_zones             = var.public_ip_zones
  public_ip_ids               = var.public_ip_ids
  nat_gateway_idle_timeout    = var.nat_gateway_idle_timeout
  tags                        = local.additional_tags
}

# module "logging" {
#   count                     = var.enable_logging ? 1 : 0
#   source                    = "./modules/logging"
#   name                      = var.name
#   environment               = var.environment
#   resource_group_location   = var.resource_group_location
#   resource_group_name       = module.resource-group.resource_group_name
#   network_security_group_id = module.network_security_group[0].network_security_group_id
#   tags                      = local.additional_tags
# }

module "vpn" {
  count                     = var.create_vpn ? 1 : 0
  depends_on                = [module.vnet]
  source                    = "./modules/vpn"
  name                      = var.name
  environment               = var.environment
  resource_group_location   = var.resource_group_location
  resource_group_name       = module.resource-group.resource_group_name
  network_security_group_id = module.network_security_group[0].network_security_group_id
  tags                      = local.additional_tags
  subnet_id                 = slice(module.vnet[0].vnet_subnets, ((length(local.database_subnets))+(length(local.private_subnets))-1), (length(module.vnet[0].vnet_subnets)-1))
  generate_admin_ssh_key = true
  os_flavor = "linux"
}