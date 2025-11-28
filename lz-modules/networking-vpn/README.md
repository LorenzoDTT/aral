# AWS VPN Terraform module

Terraform module which creates AWS Virtual Private Network(VPN) on AWS.
### Description
>AWS Virtual Private Network (AWS VPN) establishes a secure and private tunnel from your network or device to the AWS Cloud. You can extend your existing on-premises network into a VPC, or connect to other AWS resources from a client. AWS VPN offers two types of private connectivity that feature the high availability and robust security necessary for your data.

### Amazon VPN Documentation
* [VPN](https://docs.aws.amazon.com/en_us/vpn/#aws-site-to-site-vpn)

These types of resources are supported:

* [Terraform Customer Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway.html)

* [Terraform VPN Connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection.html)

* [Terraform EC2 Transit Gateway Route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route)


## Terraform versions

Terraform v1.6.6

### Dependencies
The following resources must exist before the deployment can take place:

- AWS account.
- Transit Gateway.
- Transit Gateway Route Table.

## Architecture

![Diagram](Documentation/aws-vpn.PNG) "Architecture diagram")

## Usage

```hcl
// Complete with your GHE route module
module "VPN" {
  source              = "github.com/LorenzoDTT/aral/networking-vpn"
  providers            = { 
    aws.us_east_1 = aws.us_east_1
  }

######SPAIN#####

  transit_gateway_id_spain  = module.Transit_Gateway.transit_gateway_id_spain
  tgw_route_table_id_spain = var.tgw_route_table_id_spain

    //Orange
    customer_gateway_bgp_asn_orange = var.customer_gateway_bgp_asn_orange
    customer_gateway_ip_address_orange  = var.customer_gateway_ip_address_orange
    remote_ipv4_network_cidr_orange  = var.remote_ipv4_network_cidr_orange 
    destination_cidr_block_orange  = var.destination_cidr_block_orange

    //Diba
    customer_gateway_bgp_asn_diba = var.customer_gateway_bgp_asn_diba
    customer_gateway_ip_address_diba  = var.customer_gateway_ip_address_diba
    remote_ipv4_network_cidr_diba =  var.remote_ipv4_network_cidr_diba 
    destination_cidr_block_diba  = var.destination_cidr_block_diba 

######NORTH VIRGINIA#####

  transit_gateway_id_North_Virginia   = module.Transit_Gateway.transit_gateway_id_North_Virginia
  tgw_route_table_id_North_Virginia = var.tgw_route_table_id_North_Virginia

    # //AT&T
    customer_gateway_bgp_asn_ATYT = var.customer_gateway_bgp_asn_ATYT
    customer_gateway_ip_address_ATYT  = var.customer_gateway_ip_address_ATYT
    remote_ipv4_network_cidr_ATYT  = var.remote_ipv4_network_cidr__ATYT
    destination_cidr_block_ATYT  = var.destination_cidr_block__ATYT

    # //Spectrum
    customer_gateway_bgp_asn_spectrum = var.customer_gateway_bgp_asn_spectrum
    customer_gateway_ip_address_spectrum  = var.customer_gateway_ip_address_spectrum
    remote_ipv4_network_cidr_spectrum  = var.remote_ipv4_network_cidr_spectrum
    destination_cidr_block_spectrum   = var.destination_cidr_block_spectrum

}
```

## Examples

```hcl
module "VPN" {
  source              = "github.com/LorenzoDTT/aral/networking-transit-gateway"
  providers            = { 
    aws.us_east_1 = aws.us_east_1
  }

######SPAIN#####

  transit_gateway_id_spain  = "tgw-07dffa8eee7fdd244"
  tgw_route_table_id_spain  = "tgw-rtb-05e3f190c7983d2c1"

    //Orange
    customer_gateway_bgp_asn_orange = "65100"
    customer_gateway_ip_address_orange  = "62.37.193.114
    remote_ipv4_network_cidr_orange  = "0.0.0.0/0"
    destination_cidr_block_orange  = "10.57.57.192/26"

    //Diba
    customer_gateway_bgp_asn_diba = "65200"
    customer_gateway_ip_address_diba  = "195.53.86.50"
    remote_ipv4_network_cidr_diba = "0.0.0.0/0"
    destination_cidr_block_diba  = "10.57.57.128/26"

######NORTH VIRGINIA#####

  transit_gateway_id_North_Virginia   = "tgw-003162c06e573b1a3"
  tgw_route_table_id_North_Virginia = "tgw-rtb-0e4b25bec3fe07acd"

    # //AT&T
    customer_gateway_bgp_asn_ATYT = "65300"
    customer_gateway_ip_address_ATYT  = "12.76.53.106"
    remote_ipv4_network_cidr_ATYT  = "0.0.0.0/0"
    destination_cidr_block_ATYT  = "10.57.16.128/26"

    # //Spectrum
    customer_gateway_bgp_asn_spectrum = "65400"
    customer_gateway_ip_address_spectrum  = "71.14.158.178"
    remote_ipv4_network_cidr_spectrum  = "0.0.0.0/0"
    destination_cidr_block_spectrum   = "10.57.16.192/26"

}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12 |
| aws | ~> 2.54 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.73.0 |


# Variables
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| transit\_gateway\_id\_spain | El ID de EC2 Transit Gateway. | string | `tgw-07dffa8eee7fdd244` | No |
| tgw\_route\_table\_id\_spain | Identifier of EC2 Transit Gateway Route Table. | string | `tgw-rtb-05e3f190c7983d2c1` | Yes |
| customer\_gateway\_bgp\_asn\_orange | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | string | `65100` | Yes |
| customer\_gateway\_ip\_address\_orange | The IPv4 address for the customer gateway device's outside interface. | string | `62.37.193.114` | No |
| remote\_ipv4\_network\_cidr\_orange | The IPv4 CIDR on the AWS side of the VPN connection. | string | `0.0.0.0/0` | No |
| destination\_cidr\_block\_orange | IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match. | string | `10.57.57.192/26` | Yes |
| customer\_gateway\_bgp\_asn\_diba | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | string | `65200` | Yes |
| customer\_gateway\_ip\_address\_diba | The IPv4 address for the customer gateway device's outside interface. | string | `195.53.86.50` | No |
| remote\_ipv4\_network\_cidr\_diba | The IPv4 CIDR on the AWS side of the VPN connection. | string | `0.0.0.0/0` | No |
| destination\_cidr\_block\_diba | IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match. | string | `10.57.57.128/26` | Yes |
| transit\_gateway\_id\_North\_Virginia | El ID de EC2 Transit Gateway. | string | `tgw-003162c06e573b1a3` | No |
| tgw\_route\_table\_id\_North\_Virginia| Identifier of EC2 Transit Gateway Route Table. | string | `tgw-rtb-0e4b25bec3fe07acd` | Yes |
| customer\_gateway\_bgp\_asn\_ATYT | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | string | `65300` | Yes |
| customer\_gateway\_ip\_address\_ATYT | The IPv4 address for the customer gateway device's outside interface. | string | `12.76.53.106` | No |
| remote\_ipv4\_network\_cidr\_ATYT | The IPv4 CIDR on the AWS side of the VPN connection. | string | `0.0.0.0/0` | No |
| destination\_cidr\_block\_ATYT | IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match. | string | `10.57.16.128/26` | Yes |
| customer\_gateway\_bgp\_asn\_spectrum | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | string | `65400` | Yes |
| customer\_gateway\_ip\_address\_spectrum | The IPv4 address for the customer gateway device's outside interface. | string | `71.14.158.178` | No |
| remote\_ipv4\_network\_cidr\_spectrum | The IPv4 CIDR on the AWS side of the VPN connection. | string | `0.0.0.0/0` | No |
| destination\_cidr\_block\_spectrum | IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match. | string | `10.57.16.192/26` | Yes |

## Outputs

| Name | Description |
|------|-------------|
| vpn\_connection\_id\_orange | The ID created for the VPN Spain-Orange. |
| vpn\_connection\_id\_diba | The ID created for the VPN Spain-Diba. |
| vpn\_connection\_id\_ATYT | The ID created for the VPN North-Virginia-ATYT. |
| vpn\_connection\_id\_spectrum | The ID created for the VPN North-Virginia-spectrum. |

# **Basic tf files description**

This section explain the structure and elements that represent the artifacts of product.

|Folder|Name|Description
|--|:-|--|
|Documentation|aws-vpn.PNG|Architecture diagram|
|Root|README.md|Product documentation file|
|Root|main.tf|Terraform file to use in pipeline to build and release a product|
|Root|outputs.tf|Terraform file to use in pipeline to check output|
|Root|variables.tf|Terraform file to define variables|


## Authors

Module written by Deloitte