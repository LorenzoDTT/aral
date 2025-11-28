<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.nlb_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.nlb_private_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_record_dns_name"></a> [record\_dns\_name](#input\_record\_dns\_name) | The DNS name for the Route53 record | <pre>map(object({<br/>    name = string<br/>    type = string<br/>    type_alias = optional(list(object({<br/>      network  = string<br/>      zone_id  = string<br/>      weighted = number<br/>    })))<br/>  }))</pre> | n/a | yes |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | The name of the Route53 private hosted zone | `string` | n/a | yes |
| <a name="input_vpc_region"></a> [vpc\_region](#input\_vpc\_region) | The AWS region of the VPC where the NLB will be deployed | <pre>list(object({<br/>    vpc_region = string<br/>    vpc_id     = string<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.

## Usage
```hcl
module "Direct_Connect" {
  source              = ""

## configuración de Route53 privada
route53_zone_name = "printer.testing.aws.com"
vpc_region = [
  {
    vpc_region = "eu-south-2",
    vpc_id     = "vpc-0c9da2a48ce9f4b03"
  }
]
# configuración de registros DNS en Route53 para el NLB
record_dns_name = {
  deploy-dns-printers = {
    name = "nlb-printers"
    type = "A"
    type_alias = [
      {
        network  = "nlb-printers-testing-7cc447286f566f80.elb.eu-south-2.amazonaws.com"
        zone_id  = "Z1011216NVTVYADP1SSV" # Zone ID for eu-south-2 NLBs
        weighted = 98
      },
      {
        network  = "test22-e3ce7229d4a10d0f.elb.eu-south-2.amazonaws.com"
        zone_id  = "Z1011216NVTVYADP1SSV" # Zone ID for eu-south-2 NLBs
        weighted = 2
      }
    ]
  }
}
}
```

<!-- END_TF_DOCS -->