resource "azurerm_resource_group" "terraform_infra" {
  name     = var.resource_group_name
  location = var.resource_group_location

  tags = {
    "Name" = var.resource_group_name
  }
}
output "resource_group_name" {
  description = "Resource Group Name"
  value       = azurerm_resource_group.terraform_infra.name
}
output "resource_group_location" {
  description = "Resource Group Name Location"
  value       = azurerm_resource_group.terraform_infra.location
}
