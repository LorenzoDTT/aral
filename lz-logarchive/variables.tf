# global_breakglass_admin_role module
variable "name" {
  type        = string
  description = "The name of the role. "
  default     = "breakglass_admin"
}
variable "principal_arns" {
  type        = string
  description = "ARNs of accounts, groups, or users with the ability to assume this role."
  default     = "381491940389"
}
variable "policy_arns" {
  type        = string
  description = "List of ARNs of policies to be associated with the created IAM role"
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}