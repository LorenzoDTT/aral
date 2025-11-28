# List of roles ARNs authorized to assume the high privilege role created by this module
variable "deployment_name" {
  type        = string
  description = "The name of the role. "
}
variable "deployment_principal_arns" {
  type        = string
  description = "ARNs of accounts, groups, or users with the ability to assume this role."
}
variable "deployment_policy_arns" {
  type        = string
  description = "List of ARNs of policies to be associated with the created IAM role"
}