# Introduction

This terraform module can be used to create the foundational role that will be used to deploy IaC automations in LZ foundational accounts (deployment, etc.)

The role has the following permissions:
- AdministratorAccess: to perform terraform deployments
- AWSSSODirectoryAdministrator: to perform automatic permission set to AD Group assignments

Since this LZ is being using Azure AD and native SSO, MFA is enforced to be able to use this SSO Role.

# Input variables:
* `authorized_role_arns` List of authorized Role ARNs to assume this role
* `role_name` Name used to create this IAM rol