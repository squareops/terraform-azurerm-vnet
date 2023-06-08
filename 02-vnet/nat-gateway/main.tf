resource "azurerm_public_ip" "public_ip_for_nat" {
  count               = var.create_public_ip ? 1 : 0
  allocation_method   = "Static"
  location            = var.location
  name                = local.public_ip_name
  resource_group_name = var.resource_group_name
  zones               = var.public_ip_zones
  sku                 = "Standard"

  domain_name_label = var.public_ip_domain_name_label
  reverse_fqdn      = var.public_ip_reverse_fqdn

  tags = merge(
    local.default_tags,
    var.extra_tags
  )
}

resource "azurerm_nat_gateway" "natgw" {
  location                = var.location
  name                    = local.nat_gateway_name
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = var.nat_gateway_idle_timeout

  tags = merge(
    local.default_tags,
    var.extra_tags
  )
}

resource "azurerm_nat_gateway_public_ip_association" "pip_assoc" {
  count                = var.create_public_ip ? 1 : 0
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.public_ip_for_nat[0].id
}

# resource "azurerm_nat_gateway_public_ip_association" "pip_assoc_custom_ips" {
#   for_each             = toset(var.public_ip_ids)
#   nat_gateway_id       = azurerm_nat_gateway.natgw.id
#   public_ip_address_id = each.value
# }
resource "azurerm_subnet_nat_gateway_association" "subnet_assoc" {
  count =  length(var.subnet_ids)

  nat_gateway_id = azurerm_nat_gateway.natgw.id
  subnet_id      = var.subnet_ids[count.index]
}