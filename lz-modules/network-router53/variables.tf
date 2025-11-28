
variable "vpc_region" {
  description = "The AWS region of the VPC where the NLB will be deployed"
  type = list(object({
    vpc_region = string
    vpc_id     = string
  }))
}

variable "route53_zone_name" {
  description = "The name of the Route53 private hosted zone"
  type        = string

}
variable "record_dns_name" {
  description = "The DNS name for the Route53 record"
  type = map(object({
    name = string
    type = string
    type_alias = optional(list(object({
      network  = string
      zone_id  = string
      routing_policy_failover = string
    })))
  }))
}
