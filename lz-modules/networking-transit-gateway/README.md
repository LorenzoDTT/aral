# AWS TRANSIT GATEWAY Terraform module

Terraform module which creates Transit Gateway(TGW) on AWS.
### Description
>AWS Transit Gateway is a highly available and scalable service to consolidate the AWS VPC routing configuration for a region with a hub-and-spoke architecture.    
> Transit Gateways can be peered with each other within the same AWS Region or between different AWS Regions.

### Amazon Transit Gateway Documentation
* [Transit Gateway](https://docs.aws.amazon.com/es_es/whitepapers/latest/aws-vpc-connectivity-options/aws-transit-gateway.html)

These types of resources are supported:

* [Terraform EC2 Transit Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway)

* [Terraform RAM Resource Share](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share)

* [Terraform RAM Resource Association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association)

* [Terraform RAM Principal Association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association)

## Terraform versions

Terraform v1.6.6

### Dependencies
The following resources must exist before the deployment can take place:

- AWS account.

## Architecture

![Diagram](Documentation/aws-transit-gateway.PNG) "Architecture diagram")

## Usage

```hcl
// Complete with your GHE route module
module "Transit_Gateway" {
  source              = "git::codecommit::us-east-1://lz-modules.git//networking-transit-gateway"
  providers            = { 
    aws.us_east_1 = aws.us_east_1
  }

######SPAIN#####
  amazon_side_asn_spain             = var.amazon_side_asn_spain
  name_spain                        = var.name_spain

  ######NORTH VIRGINIA#####
  amazon_side_asn_North_Virginia    = var.amazon_side_asn_North_Virginia
  name_North_Virginia               = var.name_North_Virginia

}
```

## Examples

```hcl
module "Transit_Gateway" {
  source              = "git::codecommit::us-east-1://lz-modules.git//networking-transit-gateway"
  providers            = { 
    aws.us_east_1 = aws.us_east_1
  }

######SPAIN#####
  amazon_side_asn_spain             = "64512"
  name_spain                        = "tgw-Spain"

  ######NORTH VIRGINIA#####
  amazon_side_asn_North_Virginia    = "65510"
  name_North_Virginia               = "tgw-North-Virginia"

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
| name\_spain | Name of the Transit Gateway Spain. | string | `tgw-Spain` | No |
| amazon\_side\_asn\_spain | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN. | string | `64512` | No |
| name\_North\_Virginia | Name of the Transit Gateway North Virginia. | string | `tgw-North-Virginia` | No |
| amazon\_side\_asn\_North\_Virginia | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN. | string | `65510` | No |
| enable\_auto\_accept\_shared\_attachments | Whether resource attachment requests are automatically accepted. | string | `enable` | No |
| description | Description of the Transit Gateway. | string |  | No |
| tags | Tags for Transit Gateway. | map(string)  | `{}` | No |
| twg_tags | Additional tags for the TGW. | map(string)  | `{}` | No |t
| timeouts | Create, update, and delete timeout configurations for the transit gateway. | map(string)  | `{}` | No |
| sap_account_id | The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN. | string | `851725467425` | Yes |

## Outputs

| Name | Description |
|------|-------------|
| transit\_gateway\_id\_spain | The ID created for the transit gateway Spain. |
| transit\_gateway\_id\_North\_Virginia | The ID created for the transit gateway North Virginia. |

# **Basic tf files description**

This section explain the structure and elements that represent the artifacts of product.

|Folder|Name|Description
|--|:-|--|
|Documentation|aws-transit-gateway.PNG|Architecture diagram|
|Root|README.md|Product documentation file|
|Root|main.tf|Terraform file to use in pipeline to build and release a product|
|Root|outputs.tf|Terraform file to use in pipeline to check output|
|Root|variables.tf|Terraform file to define variables|


## Authors

Module written by Deloitte