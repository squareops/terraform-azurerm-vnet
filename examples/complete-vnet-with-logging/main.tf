locals {
  location      = "eastus"
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
  source                  = "../../"
  name                    = local.name
  address_space           = local.address_space
  environment             = local.name
  zones                   = 3
  create_vnet             = true
  create_resource_group   = true
  resource_group_location = local.location
  create_public_subnets   = true
  create_private_subnets  = true
  create_database_subnets = false
  create_nat_gateway      = false
  enable_logging          = false
  create_vpn              = false
  additional_tags         = local.additional_tags
}