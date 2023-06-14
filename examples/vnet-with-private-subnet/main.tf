locals {
  name        = "skaf"
  region      = "eastus"
  environment = "stage"
  additional_tags = {
    Owner      = "SquareOps"
    Expires    = "Never"
    Department = "Engineering"
  }
  address_space = "10.10.0.0/16"
}

module "vnet" {
  source                 = "../../"
  name                   = local.name
  address_space          = local.address_space
  environment            = local.environment
  zones                  = 2
  create_public_subnets  = true
  create_private_subnets = true
  create_vpn             = true
  create_nat_gateway     = true
  additional_tags        = local.additional_tags
}