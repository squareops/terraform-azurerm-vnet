locals {
  location    = "eastus"
  environment = "dev"
  name        = "skaf"
  additional_tags = {
    Owner      = "SquareOps"
    Expires    = "Never"
    Department = "Engineering"
  }
  address_space = "10.10.0.0/16"
}


module "vnet" {
  source                  = "git::https://github.com/anoushkaakhourysq/terraform-azure-vnet.git?ref=release/v1"
  name                    = local.name
  address_space           = local.address_space
  environment             = local.name
  create_vnet             = true
  create_resource_group   = true
  resource_group_location = local.location
  create_public_subnets   = true
  num_public_subnets      = 1
  create_private_subnets  = true
  num_private_subnets     = 1
  create_database_subnets = false
  num_database_subnets    = 1
  create_nat_gateway      = false
  enable_logging          = false
  create_vpn              = false
  additional_tags         = local.additional_tags
}