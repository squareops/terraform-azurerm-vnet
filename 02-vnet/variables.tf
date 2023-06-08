variable "environment" {
  default = "test" ## inserted value
  type    = string
}
variable "name" {
  default = "skaf" ## inserted value
  type    = string
}
variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    tag1 = ""
    tag2 = ""
  }
}

variable "resource_group_location" {
  default = "eastus" ## inserted value
  type    = string
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
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
  default     = null
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

variable "route_prefixes_public" {
  description = "The list of address prefixes to use for each route."
  default     = ["10.0.1.0/24"]
}

variable "route_names_public" {
  description = "A list of public subnets inside the vNet."
  default     = ["subnet1"]
}

variable "route_nexthop_types_public" {
  description = "The type of Azure hop the packet should be sent to for each corresponding route.Valid values are 'VirtualNetworkGateway', 'VnetLocal', 'Internet', 'HyperNetGateway', 'None'"
  default     = ["VnetLocal"]
}

variable "route_prefixes_private" {
  description = "The list of address prefixes to use for each route."
  default     = ["10.0.1.0/24"]
}

variable "route_names_private" {
  description = "A list of public subnets inside the vNet."
  default     = ["subnet1"]
}

variable "route_nexthop_types_private" {
  description = "The type of Azure hop the packet should be sent to for each corresponding route.Valid values are 'VirtualNetworkGateway', 'VnetLocal', 'Internet', 'HyperNetGateway', 'None'"
  default     = ["VnetLocal"]
}

variable "address_subnets_public" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  type    = list(string)
}

variable "subnet_names_public" {
  default = ["subnet-1", "subnet-2", "subnet-3"]
  type    = list(string)
}

variable "address_subnets_private" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  type    = list(string)
}

variable "subnet_names_private" {
  default = ["subnet-1", "subnet-2", "subnet-3"]
  type    = list(string)
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
