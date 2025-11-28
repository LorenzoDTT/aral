variable "name" {
  type        = string
  description = "The name of the role. "
}
variable "principal_arns" {
  type        = string
  description = "ARNs of accounts, groups, or users with the ability to assume this role."
}
variable "policy_arns" {
  type        = string
  description = "List of ARNs of policies to be associated with the created IAM role"
}