# Module Account VPC

This module creates a VPC in the account where it is deployed according to the types of sizes defined by the company (xsmall, small, medium, etc.). In addition, this module connects to the shared services account where the IPAM service is located, which provides network addressing or CIDR to the VPC, depending on its usage and environment. In addition, it creates a Transit Gateway attachment that integrates this VPC into the company's corporate network environment. It also sets the default route from the subnets to the organization's Transit Gateway. Finally, this module creates a generic DHCP configuration linked to the VPC it creates, using as dns servers, the one provided by AWS, that is, the vpc's own.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.70.0 |
| <a name="provider_aws.sharedservices"></a> [aws.sharedservices](#provider\_aws.sharedservices) | >= 3.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.workload](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_route_table.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_ssm_parameter.application_subnet_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.data_subnet_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.frontend_subnet_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpc_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_subnet.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.workload](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.workload](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.workload](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_endpoint.s3_vpcendpoint_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_caller_identity.context](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.context](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssm_parameter.ipam_pool_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.tgw_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_vpc.workload](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | The availability zones | `list(string)` | n/a | yes |
| <a name="input_create_s3_gwvpce"></a> [create\_s3\_gwvpce](#input\_create\_s3\_gwvpce) | Create S3 Gateway VPC Endpoint | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment dev, pre, pro, shr | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | n/a | yes |
| <a name="input_vpc_size"></a> [vpc\_size](#input\_vpc\_size) | The size of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_subnet_id"></a> [application\_subnet\_id](#output\_application\_subnet\_id) | The ID of the application subnet |
| <a name="output_aws_router_table_application_id"></a> [aws\_router\_table\_application\_id](#output\_aws\_router\_table\_application\_id) | The ID of the application route table |
| <a name="output_aws_router_table_data_id"></a> [aws\_router\_table\_data\_id](#output\_aws\_router\_table\_data\_id) | The ID of the data route table |
| <a name="output_data_subnet_id"></a> [data\_subnet\_id](#output\_data\_subnet\_id) | The ID of the data subnet |
| <a name="output_frontend_subnet_id"></a> [frontend\_subnet\_id](#output\_frontend\_subnet\_id) | The ID of the frontend subnet |
| <a name="output_routeroute_table_frontend_id"></a> [routeroute\_table\_frontend\_id](#output\_routeroute\_table\_frontend\_id) | The ID of the frontend route table |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |



## Terraform
### Example 
```terraform
module "workload-vpc-dev-custom" {
  source             = ""
  vpc_name           = "deloitte-workload-xsmall"
  vpc_size           = "xsmall"
  environment        = "dev"
  availability_zones = ["eu-south-2a","eu-south-2b"]
  create_s3_gwvpce   = true
  providers = {
    aws.sharedservices = aws.sharedservices
  }
}
```