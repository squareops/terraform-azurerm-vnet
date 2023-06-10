output "resource_group_name" {
  description = "Resource Group Name"
  value       = module.resource-group.resource_group_name
}
output "resource_group_location" {
  description = "Resource Group Name Location"
  value       = module.resource-group.resource_group_location
}

output "vnet_id" {
  value = module.vnet[0].vnet_id
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = module.vnet[0].vnet_name
}

output "vnet_subnets_name_id" {
  description = "Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = module.vnet[0].vnet_subnets_name_id
}

output "network_security_group_id" {
  description = "The id of newly created network security group"
  value       = module.network_security_group[0].network_security_group_id
}

output "route_table_id_database" {
  description = "The id of the newly created Route Table for Databases"
  value       = module.routetable_database[0].routetable_id
}

output "route_table_id_private" {
  description = "The id of the newly created Route Table"
  value       = module.routetable_private[0].routetable_id
}

output "route_table_id_public" {
  description = "The id of the newly created Route Table"
  value       = module.routetable_public[0].routetable_id
}

output "nat_gateway_id" {
  description = "Nat Gateway Id"
  value       = module.nat_gateway[0].nat_gateway_id
}

output "nat_gateway_name" {
  description = "Nat gateway Name"
  value       = module.nat_gateway[0].nat_gateway_name
}

output "nat_gateway_public_ips" {
  description = "Public IPs associated to Nat Gateway"
  value       = module.nat_gateway[0].nat_gateway_public_ips
}