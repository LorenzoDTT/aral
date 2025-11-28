# SSO permission set creation and modification within the LZ idcenter account for the whole LZ (all LZ accounts)

Module designed to implement the access control model in Control Tower LZ by the use of IAM Identity Center permission sets.

## Privilege grants
IAM Identity Center permission sets are granted with privilege grants by policy attachments.
There are 3 types of policies being considered in this version of the module:
- inline policies based on JSON templates (see /iam folder)
- aws managed policies
- customer managed policies to deploy grants at account level

## Permission sets
Permission sets are created in the LZ management account with IAM Identity Center AWS service.
They must be created first before you enforce the access to the LZ by group membership by including the AD Group assignment to the permission set

## Requirements
This module is called from lz-management->main.tf using:

module "permission_sets" {
  source    = "github.com/LorenzoDTT/aral.git//management-permission-sets"
  providers = { aws = aws.us_east_1 }
  permission_sets = [

In the main.tf file, you can create more permissions sets following the documentation: AWS Gestión de Permisos de usuarios y grupos mediante Terraform.docx

