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
| [aws_lb.nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.nlb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.targets_ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the NLB (e.g., dev, staging, prod) | `string` | `"testing"` | no |
| <a name="input_lb_listeners"></a> [lb\_listeners](#input\_lb\_listeners) | A map of listener configurations for the NLB | <pre>map(object({<br/>    port     = number<br/>    protocol = string<br/>    weight   = optional(number)<br/>    vpc_id   = optional(string)<br/>    target_group = optional(list(object({<br/>      target_ip = string<br/>      port      = number<br/>    })))<br/>  }))</pre> | `{}` | no |
| <a name="input_naming"></a> [naming](#input\_naming) | Naming prefix for the NLB | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of security group IDs to associate with the NLB | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet IDs where the NLB will be deployed | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nlb_arn"></a> [nlb\_arn](#output\_nlb\_arn) | The ARN of the load balancer |
| <a name="output_nlb_dns_name"></a> [nlb\_dns\_name](#output\_nlb\_dns\_name) | The DNS name of the load balancer |
| <a name="output_nlb_zone_id"></a> [nlb\_zone\_id](#output\_nlb\_zone\_id) | The Route 53 zone ID of the load balancer |

## Usage
```hcl
module "Direct_Connect" {
  source              = ""
### Network Load Balancer Module - Test Variables
naming          = "printers"
subnets         = ["subnet-0a36f5da8e0752a6b", "subnet-0384bd7f694d4c237"]
security_groups = ["sg-0186e1a7c068f5e2b"] # necesario para NLB interno
environment     = "testing"

tags = {
  Project = "NetworkLoadBalancerModule"
}

lb_listeners = {
  listener1 = {
    vpc_id   = "vpc-0c9da2a48ce9f4b03"
    port     = 80
    protocol = "TCP"
    weight   = 100
    target_group = [
      {
        target_ip = "10.1.1.43"
        port      = 80
      },
       {
        target_ip = "10.1.1.44"
        port      = 80
      } 
    ]
  },
   listener2 = {
    vpc_id   = "vpc-0c9da2a48ce9f4b03"
    port     = 515
    protocol = "TCP"
    weight   = 2
    target_group = [
      {
        target_ip = "10.1.1.26"
        port      = 80
      }
    ]
  } 
}

}
```

<!-- END_TF_DOCS -->