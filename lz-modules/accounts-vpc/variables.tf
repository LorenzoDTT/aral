variable "availability_zones" {
  description = "The availability zones"
  type        = list(string)
}

variable "vpc_size" {
  description = "The size of the VPC"
  type        = string
  validation {
    condition     = contains(["xsmall", "small", "medium", "large", "xlarge"], var.vpc_size)
    error_message = "Must be xsmall, small, medium, large or xlarge size."
  }
}

variable "environment" {
  description = "The environment dev, pre, pro, shr"
  type        = string
  validation {
    condition     = contains(["dev", "pre", "pro", "shr"], var.environment)
    error_message = "Variable environment must be: dev, pre, pro or shr in Workloads or dcdev, dcpre, dcpro in Datacenters."
  }
}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "create_s3_gwvpce" {
  description = "Create S3 Gateway VPC Endpoint"
  type        = bool
  default     = true
}

variable "create_route53_resolver_inbound" {
  description = "Create Route53 Resolver Inbound Endpoint"
  type        = bool
  default     = false
  
}