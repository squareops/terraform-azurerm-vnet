# AWS Network Terraform module

![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.

<br>
Terraform module to create Networking resources for workload deployment on Azure Cloud.

## Usage Example

```hcl

module "vnet" {
  source                                          = "<path-to-module>"
  name                                            = "skaf"
  address_space                                   = "10.0.0.0/16"
  environment                                     = "production"
  zones                                           = 2
  create_vnet                                     = true
  create_public_subnets                           = true
  create_private_subnets                          = true
  create_database_subnets                         = true
  create_nat_gateway                              = true
  enable_logging                                  = true
  address_subnets_database                        = ["10.0.1.0/24"]
  address_subnets_private                         = ["10.0.2.0/24"]
  address_subnets_public                          = ["10.0.3.0/24"]  
}
```
Refer [this](https://github.com/squareops/terraform-aws-vpc/tree/main/examples) for more examples.


## Important Note
To prevent destruction interruptions, any resources that have been created outside of Terraform and attached to the resources provisioned by Terraform must be deleted before the module is destroyed.

## Network Scenarios

Users need to declare `address_space` and subnets are calculated with the help of in-built functions.

This module supports three scenarios to create Network resource on AWS. Each will be explained in brief in the corresponding sections.

- **simple-vnet (default behavior):** To create a VNet with public subnets and Internet Route Hop.
  - `create_vnet       = "true"`
  - `create_public_subnets = true`
- **vnet-with-private-sub:** To create a VNet with public subnets, private subnets, Internet Route Hop and NAT gateway. Database and Private, whichever subnets are enabled, are associated with the NAT gateway.
  - `create_vnet       = "true"`
  - `create_public_subnets = true`
  - `create_public_subnets = true`


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_assign_public_ip"></a> [auto\_assign\_public\_ip](#input\_auto\_assign\_public\_ip) | Specify true to indicate that instances launched into the subnet should be assigned a public IP address. | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Number of Availability Zone to be used by VPC Subnets | `number` | `2` | no |
| <a name="input_database_subnet_cidrs"></a> [database\_subnet\_cidrs](#input\_database\_subnet\_cidrs) | Database Tier subnet CIDRs to be created | `list(any)` | `[]` | no |
| <a name="input_database_subnet_enabled"></a> [database\_subnet\_enabled](#input\_database\_subnet\_enabled) | Set true to enable database subnets | `bool` | `false` | no |
| <a name="input_default_network_acl_ingress"></a> [default\_network\_acl\_ingress](#input\_default\_network\_acl\_ingress) | List of maps of ingress rules to set on the Default Network ACL | `list(map(string))` | <pre>[<br>  {<br>    "action": "deny",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "rule_no": 98,<br>    "to_port": 22<br>  },<br>  {<br>    "action": "deny",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 3389,<br>    "protocol": "tcp",<br>    "rule_no": 99,<br>    "to_port": 3389<br>  },<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_no": 100,<br>    "to_port": 0<br>  },<br>  {<br>    "action": "allow",<br>    "from_port": 0,<br>    "ipv6_cidr_block": "::/0",<br>    "protocol": "-1",<br>    "rule_no": 101,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Specify the environment indentifier for the VPC | `string` | `""` | no |
| <a name="input_flow_log_cloudwatch_log_group_retention_in_days"></a> [flow\_log\_cloudwatch\_log\_group\_retention\_in\_days](#input\_flow\_log\_cloudwatch\_log\_group\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group for VPC flow logs. | `number` | `null` | no |
| <a name="input_flow_log_enabled"></a> [flow\_log\_enabled](#input\_flow\_log\_enabled) | Whether or not to enable VPC Flow Logs | `bool` | `false` | no |
| <a name="input_flow_log_max_aggregation_interval"></a> [flow\_log\_max\_aggregation\_interval](#input\_flow\_log\_max\_aggregation\_interval) | The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60` seconds or `600` seconds. | `number` | `60` | no |
| <a name="input_intra_subnet_cidrs"></a> [intra\_subnet\_cidrs](#input\_intra\_subnet\_cidrs) | A list of intra subnets CIDR to be created | `list(any)` | `[]` | no |
| <a name="input_intra_subnet_enabled"></a> [intra\_subnet\_enabled](#input\_intra\_subnet\_enabled) | Set true to enable intra subnets | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Specify the name of the VPC | `string` | `""` | no |
| <a name="input_one_nat_gateway_per_az"></a> [one\_nat\_gateway\_per\_az](#input\_one\_nat\_gateway\_per\_az) | Set to true if a NAT Gateway is required per availability zone for Private Subnet Tier | `bool` | `false` | no |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | A list of private subnets CIDR to be created inside the VPC | `list(any)` | `[]` | no |
| <a name="input_private_subnet_enabled"></a> [private\_subnet\_enabled](#input\_private\_subnet\_enabled) | Set true to enable private subnets | `bool` | `false` | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | A list of public subnets CIDR to be created inside the VPC | `list(any)` | `[]` | no |
| <a name="input_public_subnet_enabled"></a> [public\_subnet\_enabled](#input\_public\_subnet\_enabled) | Set true to enable public subnets | `bool` | `false` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block of the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpn_key_pair_name"></a> [vpn\_key\_pair\_name](#input\_vpn\_key\_pair\_name) | Specify the name of AWS Keypair to be used for VPN Server | `string` | `""` | no |
| <a name="input_vpn_server_enabled"></a> [vpn\_server\_enabled](#input\_vpn\_server\_enabled) | Set to true if you want to deploy VPN Gateway resource and attach it to the VPC | `bool` | `false` | no |
| <a name="input_vpn_server_instance_type"></a> [vpn\_server\_instance\_type](#input\_vpn\_server\_instance\_type) | EC2 instance Type for VPN Server, Only amd64 based instance type are supported eg. t2.medium, t3.micro, c5a.large etc. | `string` | `"t3a.small"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | List of IDs of database subnets |
| <a name="output_intra_subnets"></a> [intra\_subnets](#output\_intra\_subnets) | List of IDs of Intra subnets |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | IPV4 CIDR Block for this VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpn_host_public_ip"></a> [vpn\_host\_public\_ip](#output\_vpn\_host\_public\_ip) | IP Address of VPN Server |
| <a name="output_vpn_security_group"></a> [vpn\_security\_group](#output\_vpn\_security\_group) | Security Group ID of VPN Server |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribute & Issue Report

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/squareops/terraform-aws-vpc/issues) on GitHub
  2. Search to check if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Make sure to provide enough context and details.

## License

Apache License, Version 2.0, January 2004 (https://www.apache.org/licenses/LICENSE-2.0)

## Support Us

To support our GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the [GitHub repository](https://github.com/squareops/terraform-aws-vpc)

  2. Click the "Star" button: On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Staring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 5 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

To find more information about our company, visit [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).