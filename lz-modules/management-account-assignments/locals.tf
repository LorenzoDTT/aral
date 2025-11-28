#-----------------------------------------------------------------------------------------------------------------------
# LOCAL VARIABLES AND DATA SOURCES
#-----------------------------------------------------------------------------------------------------------------------
data "aws_ssoadmin_instances" "this" {}

locals {
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  sso_instance_arn  = tolist(data.aws_ssoadmin_instances.this.arns)[0]

  expanded_assignments = flatten([
    for a in var.account_assignments : [
      for acc in a.account : {
        account             = acc
        permission_set_name = a.permission_set_name
        permission_set_arn  = a.permission_set_arn
        principal_name      = a.principal_name
        principal_type      = a.principal_type
      }
    ]
  ])

  group_list = toset([for mapping in var.account_assignments : mapping.principal_name if mapping.principal_type == "GROUP"])
  user_list  = toset([for mapping in var.account_assignments : mapping.principal_name if mapping.principal_type == "USER"])
}