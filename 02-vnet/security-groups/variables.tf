variable "subnet_prefixes" {
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
variable "source_address_prefix" {
  default = [] ## inserted value
  type    = list(string)
}
variable "vnet_subnets" {
  default = ["subnet-1", "subnet-2", "subnet-3"]
  type    = list(string)
}