
variable "environment" {
  description = "The environment for the NLB (e.g., dev, staging, prod)"
  type        = string
  default     = "testing"

}
variable "vpc_id" {
  description = "The VPC ID where the NLB will be deployed Security Group"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "A list of subnet IDs where the NLB will be deployed"
  type        = list(string)
}

/* variable "security_groups" {
  description = "A list of security group IDs to associate with the NLB"
  type        = list(string)
  default     = []
} */

variable "naming" {
  description = "Naming prefix for the NLB"
  type        = string
}

variable "lb_listeners" {
  description = "A map of listener configurations for the NLB"
  type = map(object({
    port     = number
    protocol = string
    weight   = optional(number, 100)
    vpc_id   = optional(string)
    target_group = optional(list(object({
      target_ip = string
      port      = number
    })))
  }))
  default = {}
}