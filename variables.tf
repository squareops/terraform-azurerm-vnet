variable "zones" {
  description = "Number of Availability Zone to be used by VNet"
  default     = 3
  type        = number
}

variable "additional_tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    tag1 = ""
    tag2 = ""
  }
}

variable "create_resource_group" {
  description = "Should we create a public IP or not?"
  type        = bool
  default     = true
}
variable "create_vnet" {
  description = "Should we create a VNet or not?"
  type        = bool
  default     = true
}
variable "create_public_subnets" {
  description = "Should we create a public subnets or not?"
  type        = bool
  default     = true
}
variable "create_private_subnets" {
  description = "Should we create a private subnets or not?"
  type        = bool
  default     = true
}
variable "create_database_subnets" {
  description = "Should we create a private subnets or not?"
  type        = bool
  default     = true
}
variable "create_network_security_group" {
  description = "Should we create a network security group or not?"
  type        = bool
  default     = true
}
variable "create_nat_gateway" {
  description = "Should we create a NAT Gateway or not?"
  type        = bool
  default     = true
}
variable "create_vpn" {
  description = "Should we create a vpn or not?"
  type        = bool
  default     = true
}
variable "environment" {
  default = "test" ## inserted value
  type    = string
}
variable "name" {
  default = "skaf" ## inserted value
  type    = string
}

variable "resource_group_location" {
  default = "eastus" ## inserted value
  type    = string
}

variable "address_space" {
  type        = string
  description = "The address space that is used by the virtual network."
  default     = "10.0.0.0/16"
}
variable "ddos_protection_plan" {
  description = "The set of DDoS protection plan configuration"
  type = object({
    enable = bool
    id     = string
  })
  default = null
}

variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "public_ip_zones" {
  description = "Public ip Zones to configure."
  type        = list(string)
  default     = ["1", "2"]
}

variable "public_ip_ids" {
  description = "List of public ips to use. Create one ip if not provided"
  type        = list(string)
  default     = []
}

variable "public_ip_domain_name_label" {
  description = "DNS domain label for NAT Gateway public IP."
  type        = string
  default     = null
}

variable "public_ip_reverse_fqdn" {
  description = "Reverse FQDN for NAT Gateway public IP."
  type        = string
  default     = null
}

variable "create_public_ip" {
  description = "Should we create a public IP or not?"
  type        = bool
  default     = true
}

variable "nat_gateway_idle_timeout" {
  description = "Idle timeout configuration in minutes for Nat Gateway"
  type        = number
  default     = 4
}


variable "disable_bgp_route_propagation_public" {
  description = "Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable."
  default     = "true"
}

variable "disable_bgp_route_propagation_private" {
  description = "Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable."
  default     = "true"
}

variable "disable_bgp_route_propagation_database" {
  description = "Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable."
  default     = "true"
}

variable "route_prefixes_public" {
  description = "The list of address prefixes to use for each route."
  default     = []
}

variable "route_names_public" {
  description = "A list of public subnets inside the vNet."
  default     = []
}

variable "route_nexthop_types_public" {
  description = "The type of Azure hop the packet should be sent to for each corresponding route.Valid values are 'VirtualNetworkGateway', 'VnetLocal', 'Internet', 'HyperNetGateway', 'None'"
  default     = []
}

variable "route_prefixes_database" {
  description = "The list of address prefixes to use for each route."
  default     = []
}

variable "route_names_database" {
  description = "A list of database subnets inside the vNet."
  default     = []
}

variable "route_nexthop_types_database" {
  description = "The type of Azure hop the packet should be sent to for each corresponding route.Valid values are 'VirtualNetworkGateway', 'VnetLocal', 'Internet', 'HyperNetGateway', 'None'"
  default     = []
}

variable "route_prefixes_private" {
  description = "The list of address prefixes to use for each route."
  default     = []
}

variable "route_names_private" {
  description = "A list of public subnets inside the vNet."
  default     = []
}

variable "route_nexthop_types_private" {
  description = "The type of Azure hop the packet should be sent to for each corresponding route.Valid values are 'VirtualNetworkGateway', 'VnetLocal', 'Internet', 'HyperNetGateway', 'None'"
  default     = []
}

variable "address_subnets_public" {
  default = []
  type    = list(any)
}

variable "subnet_names_public" {
  default = []
  type    = list(any)
}

variable "address_subnets_private" {
  default = []
  type    = list(any)
}

variable "subnet_names_private" {
  default = []
  type    = list(any)
}

variable "address_subnets_database" {
  default = []
  type    = list(any)
}

variable "subnet_names_database" {
  default = []
  type    = list(any)
}

variable "subnet_enforce_private_link_service_network_policies_public" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private link service network policies on the subnet."
}
variable "subnet_enforce_private_link_endpoint_network_policies_public" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private link endpoint network policies on the subnet."
}
variable "subnet_delegation_public" {
  type        = map(map(any))
  default     = {}
  description = "A map of subnet name to delegation block on the subnet"
}
variable "subnet_service_endpoints_public" {
  type        = map(any)
  default     = {}
  description = "A map of subnet name to service endpoints to add to the subnet."
}
variable "source_address_prefix" {
  default = [] ## inserted value
  type    = list(string)
}
variable "bgp_community" {
  type        = string
  description = "(Optional) The BGP community attribute in format `<as-number>:<community-value>`."
  default     = null
}

variable "subnet_enforce_private_link_service_network_policies_private" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private link service network policies on the subnet."
}
variable "subnet_enforce_private_link_endpoint_network_policies_private" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private link endpoint network policies on the subnet."
}
variable "subnet_delegation_private" {
  type        = map(map(any))
  default     = {}
  description = "A map of subnet name to delegation block on the subnet"
}
variable "subnet_service_endpoints_private" {
  type        = map(any)
  default     = {}
  description = "A map of subnet name to service endpoints to add to the subnet."
}
variable "enable_logging" {
  type        = string
  description = "To enable NSG Logging"
  default     = true
}