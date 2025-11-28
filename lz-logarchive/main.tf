# Create breakglass admin role in the account
module "global_breakglass_admin_role" {
  source         = "git::codecommit::us-east-1://lz-modules.git//global-admin-role"
  name           = var.name
  principal_arns = var.principal_arns
  policy_arns    = var.policy_arns
}

# Set global alernate contacts
module "alternate_contacts" {
  source         = "git::codecommit::us-east-1://lz-modules.git//global-alternate-contacts"
  resource_sufix = "alternate-contacts"
}

# Security configurations to apply at account level in all LZ accounts
# Pattern 1: Block Public Access in S3 service at account level
# You can add more security configurations in AWS by the use of this module
module "lz_security_baseline" {
  source = "git::codecommit::us-east-1://lz-modules.git//global-security-baseline"
}