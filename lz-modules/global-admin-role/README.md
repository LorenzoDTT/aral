# Introduction

This terraform module can be used as global customization to create the breakglass_admin role in AWS accounts.
This role can be assumed by the breakglass-admin user from the brealglass access account, 381491940389, with Administrator policy.
This module is called using this code in the main.tf file in each account:

module "global_breakglass_admin_role" {
  source         = "github.com/LorenzoDTT/aral//global-admin-role"
  name           = var.name
  principal_arns = var.principal_arns
  policy_arns    = var.policy_arns
}

Also, this module is supported with the defined variables in the variables.tf file in each account.

See also: AWS Acceso BreakGlass.docx