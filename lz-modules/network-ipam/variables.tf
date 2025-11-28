variable "ipam_regions" {
  description = "The regions for the IPAM"
  type        = list(any)
  default     = ["eu-south-2"]
}
variable "principal_pool_cidr" {
  description = "The CIDR for the principal pool"
  type        = list(string)
  default     = []
}
variable "ipam_pools_spain" {
  description = "The IPAM pools for Spain"
  type = map(object({
    description           = string
    locale                = string
    cidr                  = list(string)
    management_account_id = string
    organizations_id      = string
    ram_workloads         = list(string)
  }))
  default = {}
}

variable "ipam_pools_virginia" {
  description = "The IPAM pools for Virginia"
  type = map(object({
    description           = string
    locale                = string
    cidr                  = list(string)
    management_account_id = string
    organizations_id      = string
    ram_workloads         = optional(list(string), [])
  }))
  default = {}
}