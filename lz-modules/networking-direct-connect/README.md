# AWS Direct Connect Terraform module

Terraform module which creates Direct Connect(DX) on AWS.
### Description
>AWS Direct Connect establishes a dedicated network connection between your on-premises network and AWS. With this connection in place, you can create virtual interfaces directly to the AWS Cloud, bypassing your internet service provider. This can provide a more consistent network experience.

### Amazon Direct Connect Documentation
* [Direct Connect](https://docs.aws.amazon.com/directconnect/)

These types of resources are supported:

* [Terraform DX Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway)

* [Terraform DX Gateway Association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway_association)

* [Terraform DX Transit Virtual Interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_transit_virtual_interface)


## Terraform versions

Terraform v1.6.6

### Dependencies
The following resources must exist before the deployment can take place:

- AWS account.
- Transit Gateway.

## Architecture

![Diagram](Documentation/aws-direct-connect.PNG) "Architecture diagram")

## Usage

```hcl
// Complete with your GHE route module
module "Direct_Connect" {
  source              = "github.com/LorenzoDTT/aral/networking-direct-connect"
  providers            = { 
    aws.us_east_1 = aws.us_east_1,
    aws.eu_central_1 = aws.eu_central_1,
  }

######SPAIN#####

  amazon_dx_side_asn_spain     = var.amazon_dx_side_asn_spain
  transit_gateway_id_spain  = var.transit_gateway_id_spain
  dx_bgp_asn_spain             = var.dx_bgp_asn_spain
  vlan_spain                = var.vlan_spain
  bgp_auth_key_Spain          = var.bgp_auth_key_Spain

  connection_id_Spain_Telefonica1 = var.connection_id_Spain_Telefonica1
  amazon_address_Spain_Telefonica1 = var.amazon_address_Spain_Telefonica1
  customer_address_Spain_Telefonica1 = var.customer_address_Spain_Telefonica1

  connection_id_Spain_Telefonica2 = var.connection_id_Spain_Telefonica2
  amazon_address_Spain_Telefonica2 = var.amazon_address_Spain_Telefonica2
  customer_address_Spain_Telefonica2 = var.customer_address_Spain_Telefonica2

######NORTH VIRGINIA#####

  transit_gateway_id_North_Virginia  = module.Transit_Gateway.transit_gateway_id_North_Virginia
  amazon_dx_side_asn_North_Virginia  = var.amazon_dx_side_asn_North_Virginia
  bgp_asn_North_Virginia             = var.dx_bgp_asn_North_Virginia
  vlan_North_Virginia                = var.vlan_North_Virginia
  bgp_auth_key_North_Virginia        = var.bgp_auth_key_North_Virginia

  connection_id_North_Virginia_ATYT1 = var.connection_id_North_Virginia_ATYT1
  amazon_address_North_Virginia_ATYT1 = var.amazon_address_North_Virginia_ATYT1
  customer_address_North_Virginia_ATYT1 = var.customer_address_North_Virginia_ATYT1

  connection_id_North_Virginia_ATYT2 = var.connection_id_North_Virginia_ATYT2
  amazon_address_North_Virginia_ATYT2 = var.amazon_address_North_Virginia_ATYT2
  customer_address_North_Virginia_ATYT2 = var.customer_address_North_Virginia_ATYT2
}
```

## Examples

```hcl
module "Direct_Connect" {
  source              = "github.com/LorenzoDTT/aral/networking-direct-connect"
  providers            = { 
    aws.us_east_1 = aws.us_east_1,
    aws.eu_central_1 = aws.eu_central_1,
  }

######SPAIN#####

  transit_gateway_id_spain     = "tgw-07dffa8eee7fdd244"
  amazon_dx_side_asn_spain     = "64522"
  dx_bgp_asn_spain             = "12956"
  vlan_spain                   = "125"
  bgp_auth_key_Spain           = "AMAZONTDESP105420"

  connection_id_Spain_Telefonica1 = "dxcon-fgaax5i2"
  amazon_address_Spain_Telefonica1 = "10.31.128.10/30"
  customer_address_Spain_Telefonica1 = "10.31.128.9/30"

  connection_id_Spain_Telefonica2 = "dxcon-fhbgd1jj"
  amazon_address_Spain_Telefonica2 = "10.31.128.14/30"
  customer_address_Spain_Telefonica2 = "10.31.128.13/30"

######NORTH VIRGINIA#####

  transit_gateway_id_North_Virginia  = "tgw-003162c06e573b1a3"
  amazon_dx_side_asn_North_Virginia  = "65512"
  bgp_asn_North_Virginia             = "13979"
  vlan_North_Virginia                = "5"
  bgp_auth_key_North_Virginia        = "373533211019"

  connection_id_North_Virginia_ATYT1 = "dxcon-fh9tohae"
  amazon_address_North_Virginia_ATYT1 = "10.254.254.98/29"
  customer_address_North_Virginia_ATYT1 = "10.254.254.97/29"

  connection_id_North_Virginia_ATYT2 = "dxcon-fhd6fo75"
  amazon_address_North_Virginia_ATYT2 = "10.254.254.106/29"
  customer_address_North_Virginia_ATYT2 = "10.254.254.105/29"

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
| amazon\_dx\_side\_asn\_spain | The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294. | string | `64522` | Yes |
| dx\_bgp\_asn\_spain | The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration. | string | `12956` | Yes |
| vlan\_spain | The VLAN ID. | string | `125` | Yes |
| bgp\_auth\_key\_Spain | The authentication key for BGP configuration. | string | `AMAZONTDESP105420` | No |
| connection\_id\_Spain\_Telefonica1 | The ID of the Direct Connect connection (or LAG) on which to create the virtual interface. | string | `dxcon-fgaax5i2` | Yes |
| amazon\_address\_Spain\_Telefonica1 | The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers. | string | `10.31.128.10/30` | No |
| customer\_address\_Spain\_Telefonica1 | The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers. | string | `10.31.128.9/30` | No |
| connection\_id\_Spain\_Telefonica2 | The ID of the Direct Connect connection (or LAG) on which to create the virtual interface. | string | `dxcon-fhbgd1jj` | Yes |
| amazon\_address\_Spain\_Telefonica2 | The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers. | string | `10.31.128.14/30` | No |
| customer\_address\_Spain\_Telefonica2 | The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers. | string | `10.31.128.13/30` | No |
| transit\_gateway\_id\_North\_Virginia | El ID de EC2 Transit Gateway. | string | `tgw-003162c06e573b1a3` | No |
| amazon\_dx\_side\_asn\_North\_Virginia | The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294. | string | `65512` | Yes |
| dx\_bgp\_asn\_North\_Virginia | The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration. | string | `13979` | Yes |
| vlan\_spain | The VLAN ID. | string | `5` | Yes |
| bgp\_auth\_key\_North\_Virginia | The authentication key for BGP configuration. | string | `373533211019` | No |
| connection\_id\_North\_Virginia\_ATYT1 | The ID of the Direct Connect connection (or LAG) on which to create the virtual interface. | string | `dxcon-fh9tohae` | Yes |
| amazon\_address\_North\_Virginia\_ATYT1 | The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers. | string | `10.254.254.98/29` | No |
| customer\_address\_North\_Virginia\_ATYT1 | The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers. | string | `10.254.254.97/29` | No |
| connection\_id\_North\_Virginia\_ATYT2 | The ID of the Direct Connect connection (or LAG) on which to create the virtual interface. | string | `dxcon-fhd6fo75` | Yes |
| amazon\_address\_North\_Virginia\_ATYT2 | The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers. | string | `10.254.254.106/29` | No |
| customer\_address\_North\_Virginia\_ATYT2 | The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers. | string | `10.254.254.105/29` | No |


# **Basic tf files description**

This section explain the structure and elements that represent the artifacts of product.

|Folder|Name|Description
|--|:-|--|
|Documentation|aws-direct-connect.PNG|Architecture diagram|
|Root|README.md|Product documentation file|
|Root|main.tf|Terraform file to use in pipeline to build and release a product|
|Root|variables.tf|Terraform file to define variables|


## Authors

Module written by Deloitte