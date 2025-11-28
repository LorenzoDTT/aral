# Introduction

This terraform module has been used to create the breakglass-admin user in the break Glass Access Account with AdministratorAccess policy.

This module is called in lz-breakglass->main.tf using:
module "lz_breakglass_admin_user" {
  source             = "git::codecommit::us-east-1://lz-modules.git//breakglass-iam-user"
  aws_region         = "eu-south-2"
  user_name          = "breakglass-admin"
  attach_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

See also: AWS Acceso BreakGlass.docx