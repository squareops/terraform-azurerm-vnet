output "resource_group_name" {
  description = "Resource Group Name"
  value       = module.vnet.resource_group_name
}
output "resource_group_location" {
  description = "Resource Group Name Location"
  value       = module.vnet.resource_group_location
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = module.vnet.vnet_name
}

output "vnet_subnets_name_id" {
  description = "Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = module.vnet.vnet_subnets_name_id
}

output "db" {
  value = module.vnet.database_subnets
}

output "priv" {
  value = module.vnet.private_subnets
}

output "pub" {
  value = module.vnet.public_subnets
}
