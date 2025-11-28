module "global_breakglass_admin_role" {
  source         = "github.com/LorenzoDTT/aral/global-admin-role"
  name           = var.name
  principal_arns = var.principal_arns
  policy_arns    = var.policy_arns
}

# Set global alernate contacts
module "alternate_contacts" {
  source         = "github.com/LorenzoDTT/aral/global-alternate-contacts"
  resource_sufix = "alternate-contacts"
}

# Security configurations to apply at account level in all LZ accounts
# Pattern 1: Block Public Access in S3 service at account level
# You can add more security configurations in AWS by the use of this module
module "lz_security_baseline" {
  source = "github.com/LorenzoDTT/aral/global-security-baseline"
}

# Budget module #
module "budgets" {
  source       = "github.com/LorenzoDTT/aral/account-budgets"
  budget_name  = var.budget_name
  budget_type  = var.budget_type
  limit_amount = var.limit_amount
  time_unit = var.time_unit
  time_period_end   = var.time_period_end
  time_period_start = var.time_period_start
  comparison_operator = var.comparison_operator
  threshold = var.threshold
  threshold_type = var.threshold_type
  notification_type = var.notification_type
  subscriber_email_addresses = var.subscriber_email_addresses
}

# Security controls at organizational level enforced by the use of Control Tower
module "control_tower_controls" {
  source   = "github.com/LorenzoDTT/aral/management-ct-controls"
  controls = var.ct_controls
}


# Create Permission Sets
module "permission_sets" {
  source    = "github.com/LorenzoDTT/aral/management-permission-sets"
  providers = { aws = aws.us_east_1 }
  permission_sets = [
    {
      name             = "Infrastructure",
      description      = "Grant infrastructure permissions to root and all accounts.",
      relay_state      = "",
      session_duration = "PT4H",
      tags = {
        "Project"     = "Landing Zone"
        "Environment" = "pro"
        "Company"     = "Armando Alvarez"
      },
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/AdministratorAccess"],
      customer_managed_policy_attachments = []
    },
    {
      name             = "ReadOnly",
      description      = "Grant read only permissions to the landing zone accounts.",
      relay_state      = "",
      session_duration = "PT4H",
      tags = {
        "Project"     = "Landing Zone"
        "Environment" = "pro"
        "Company"     = "Armando Alvarez"
      },
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/ReadOnlyAccess"],
      customer_managed_policy_attachments = []
    },
    {
      name             = "Networking",
      description      = "Grant networking permissions to all accounts.",
      relay_state      = "",
      session_duration = "PT4H",
      tags = {
        "Project"     = "Landing Zone"
        "Environment" = "pro"
        "Company"     = "Armando Alvarez"
      },
      inline_policy = "",
      policy_attachments = [
        "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
        "arn:aws:iam::aws:policy/AmazonVPCReachabilityAnalyzerFullAccessPolicy",
        "arn:aws:iam::aws:policy/AmazonVPCNetworkAccessAnalyzerFullAccessPolicy",
        "arn:aws:iam::aws:policy/VPCLatticeFullAccess",
        "arn:aws:iam::aws:policy/job-function/NetworkAdministrator"
      ],
      customer_managed_policy_attachments = []
    },
    {
      name             = "CyberSecurity",
      description      = "Grant cyber security permissions to all accounts.",
      relay_state      = "",
      session_duration = "PT4H",
      tags = {
        "Project"     = "Landing Zone"
        "Environment" = "pro"
        "Company"     = "Armando Alvarez"
      },
      inline_policy = "",
      policy_attachments = [
        "arn:aws:iam::aws:policy/IAMFullAccess",
        "arn:aws:iam::aws:policy/AWSSecurityHubFullAccess",
        "arn:aws:iam::aws:policy/AmazonSecurityLakeAdministrator",
        "arn:aws:iam::aws:policy/AWSCloudTrail_FullAccess",
        "arn:aws:iam::aws:policy/service-role/ROSAKMSProviderPolicy",
        "arn:aws:iam::aws:policy/AmazonInspectorFullAccess",
        "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole",
        "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
        "arn:aws:iam::aws:policy/AmazonGuardDutyFullAccess",
        "arn:aws:iam::aws:policy/AmazonDetectiveFullAccess",
        "arn:aws:iam::aws:policy/AWSWAFFullAccess"
      ],
      customer_managed_policy_attachments = []
    },
    {
      name             = "DeloitteProyecto",
      description      = "Grant Deloitte Proyecto permissions to all accounts.",
      relay_state      = "",
      session_duration = "PT4H",
      tags = {
        "Project"     = "Landing Zone"
        "Environment" = "pro"
        "Company"     = "Armando Alvarez"
      },
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/AdministratorAccess"],
      customer_managed_policy_attachments = []
    },
    {
      name             = "Billing",
      description      = "Grant Billing Access.",
      relay_state      = "",
      session_duration = "PT4H",
      tags = {
        "Project"     = "Landing Zone"
        "Environment" = "pro"
        "Company"     = "Armando Alvarez"
      },
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/job-function/Billing"],
      customer_managed_policy_attachments = []
    },
    {
      name             = "aral-tf-deployment-foundational",
      description      = "Grant Foundational terraform deployment.",
      relay_state      = "",
      session_duration = "PT4H",
      tags = {
        "Project"     = "Landing Zone"
        "Environment" = "pro"
        "Company"     = "Armando Alvarez"
      },
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/AdministratorAccess"],
      customer_managed_policy_attachments = []
    }
  ]
}


# Assign permission sets to groups and accounts
module "account-assignmets" {
  source     = "github.com/LorenzoDTT/aral/management-account-assignments"
  providers  = { aws = aws.us_east_1 }
  depends_on = [module.permission_sets]
  account_assignments = [
    {
      account             = ["462322105378", "373533211019", "792028445677"]
      permission_set_name = module.permission_sets.permission_sets.DeloitteProyecto.name,
      permission_set_arn  = module.permission_sets.permission_sets.DeloitteProyecto.arn,
      principal_type      = "GROUP",
      principal_name      = "AWS_PROV_DELOITTE"
    },
    {
      account             = ["975050020540"] # Deployment Account
      permission_set_name = module.permission_sets.permission_sets.aral-tf-deployment-foundational.name,
      permission_set_arn  = module.permission_sets.permission_sets.aral-tf-deployment-foundational.arn,
      principal_type      = "GROUP",
      principal_name      = "AWS_PROV_DELOITTE"
    },
    {
      account             = ["462322105378", "373533211019", "792028445677"]
      permission_set_name = module.permission_sets.permission_sets.Infrastructure.name,
      permission_set_arn  = module.permission_sets.permission_sets.Infrastructure.arn,
      principal_type      = "GROUP",
      principal_name      = "AWS_AA_INFRAES"
    },
    {
      account             = ["975050020540"] # Deployment Account
      permission_set_name = module.permission_sets.permission_sets.aral-tf-deployment-foundational.name,
      permission_set_arn  = module.permission_sets.permission_sets.aral-tf-deployment-foundational.arn,
      principal_type      = "GROUP",
      principal_name      = "AWS_AA_INFRAES"
    },
    # ## Usuario deloitte_lz@armandoalvarez.com
    # {
    #   account             = ["792028445677"] # Management Account
    #   permission_set_name = module.permission_sets.permission_sets.DeloitteProyecto.name,
    #   permission_set_arn  = module.permission_sets.permission_sets.DeloitteProyecto.arn,
    #   principal_type      = "USER",
    #   principal_name      = "deloitte_lz@armandoalvarez.com"
    # },
    # {
    #   account             = ["975050020540"] # Deployment Account
    #   permission_set_name = module.permission_sets.permission_sets.aral-tf-deployment-foundational.name,
    #   permission_set_arn  = module.permission_sets.permission_sets.aral-tf-deployment-foundational.arn,
    #   principal_type      = "USER",
    #   principal_name      = "deloitte_lz@armandoalvarez.com"
    # },
    # Acceso de Pablo Sanz a la cuenta de management
    {
      account             = ["792028445677"] # Management Account
      permission_set_name = module.permission_sets.permission_sets.Billing.name,
      permission_set_arn  = module.permission_sets.permission_sets.Billing.arn,
      principal_type      = "USER",
      principal_name      = "psd@armandoalvarez.com"
    },
    # Acceso ReadOnly al grupo ReadOnly
    {
      account             = ["373533211019"] # Networking Account
      permission_set_name = module.permission_sets.permission_sets.ReadOnly.name,
      permission_set_arn  = module.permission_sets.permission_sets.ReadOnly.arn,
      principal_type      = "GROUP",
      principal_name      = "AWS_GLOBAL_RO"
    }
  ]
}




