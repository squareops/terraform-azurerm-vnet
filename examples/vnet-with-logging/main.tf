locals {
  region      = "eastus"
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
  name                    = "skaf"
  address_space           = "10.0.0.0/16"
  environment             = "production"
  zones                   = 2
  create_vnet             = true
  create_public_subnets   = true
  create_private_subnets  = true
  create_database_subnets = true
  create_nat_gateway      = true
  enable_logging          = true
  additional_tags         = local.additional_tags
}