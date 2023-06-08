variable "address_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  type    = list(string)
}

variable "subnet_names" {
  default = ["subnet-1", "subnet-2", "subnet-3"]
  type    = list(string)
}
variable "resource_group_name" {
  default = "skaf-test-rg" ## inserted value
  type    = string
}
variable "resource_group_location" {
  default = "eastus" ## inserted value
  type    = string
}
variable "vnet_subnets" {
  default = ["subnet-1", "subnet-2", "subnet-3"]
  type    = list(string)
}
variable "virtual_network_name" {
  default = ""
  type    = string
}
variable "route_table_id" {
  default = ""
  type    = string
}
variable "network_securitygroup_id" {
  default = ""
  type    = string
}
variable "subnet_enforce_private_link_service_network_policies" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private link service network policies on the subnet."
}
variable "subnet_enforce_private_link_endpoint_network_policies" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private link endpoint network policies on the subnet."
}
variable "subnet_delegation" {
  type        = map(map(any))
  default     = {}
  description = "A map of subnet name to delegation block on the subnet"
}
variable "subnet_service_endpoints" {
  type        = map(any)
  default     = {}
  description = "A map of subnet name to service endpoints to add to the subnet."
}