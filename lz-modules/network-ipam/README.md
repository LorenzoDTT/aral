# Module Shared Services IPAM

The following module creates the IP address Management service in the shared services account. This service has been delegated to this account and provides the service of reserving and assigning CIDRs for the different sizes and environments of the organization through different IP pools. These pools are shared with the OUs through Resource Access Manager.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.77.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ram_principal_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ssm_parameter.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_vpc_ipam.ipam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam) | resource |
| [aws_vpc_ipam_pool.ipam_pools](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool_cidr.ipam_pool_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |
| [aws_vpc_ipam_pool_cidr.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ipam_pools"></a> [ipam\_pools](#input\_ipam\_pools) | The IPAM pools | <pre>map(object({<br/>    description           = string<br/>    locale                = string<br/>    cidr                  = list(string)<br/>    management_account_id = string<br/>    organizations_id      = string<br/>    ram_workloads         = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_ipam_regions"></a> [ipam\_regions](#input\_ipam\_regions) | The regions for the IPAM | `list(any)` | <pre>[<br/>  "eu-south-2"<br/>]</pre> | no |
| <a name="input_principal_pool_cidr"></a> [principal\_pool\_cidr](#input\_principal\_pool\_cidr) | The CIDR for the principal pool | `list(string)` | `[]` | no |

## Outputs

No outputs


## Terraform
### Example Shared Services IPAM
```hcl
module "main_ipam" {
  source = ""

  principal_pool_cidr = ["XX.XXX.X.X/XX"]
  ipam_pools = {
    infra-shared-services = {
      description           = "Infra SharedServices"
      locale                = "eu-south-2"
      cidr                  = ["XX.XXX.X.X/XX"]
      management_account_id = "XXXXXXXXXXXXX"
      organizations_id      = "o-XXXXXXXXX"
      ram_workloads         = ["ou-XXXX-XXXXXXXX"]
    },
  }
}
```