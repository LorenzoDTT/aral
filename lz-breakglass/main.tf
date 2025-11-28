module "lz_breakglass_admin_user" {
  source             = "github.com/LorenzoDTT/aral.git//breakglass-iam-user"
  aws_region         = "eu-south-2"
  user_name          = "breakglass-admin"
  attach_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

# Set global alernate contacts
module "alternate_contacts" {
  source         = "github.com/LorenzoDTT/aral.git//global-alternate-contacts"
  resource_sufix = "alternate-contacts"
}

# Security configurations to apply at account level in all LZ accounts
# Pattern 1: Block Public Access in S3 service at account level
# You can add more security configurations in AWS by the use of this module
module "lz_security_baseline" {
  source = "github.com/LorenzoDTT/aral.git//global-security-baseline"
}