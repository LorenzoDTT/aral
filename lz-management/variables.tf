## Module BreakGlass Admin role
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

## Budgets Module
variable "budget_name" {
  type        = string
  description = "The name of a budget. Unique within accounts."
  default     = "MonthlyBudget"
}

variable "budget_type" {
  type        = string
  description = "Whether this budget tracks monetary cost or usage."
  default     = "COST"
}

variable "limit_amount" {
  type        = string
  description = "The amount of cost or usage being measured for a budget. "
  default     = "1000"
}

variable "time_unit" {
  type        = string
  description = "The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY"
  default     = "MONTHLY"
}

variable "time_period_end" {
  type        = string
  description = "The end of the time period covered by the budget. There are no restrictions on the end date. Format: 2017-01-01_12:00"
  default     = "2026-12-31_00:00"
}

variable "time_period_start" {
  type        = string
  description = "The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2017-01-01_12:00"
  default     = "2024-01-01_00:00"
}

variable "comparison_operator" {
  type        = string
  description = "Comparison operator to use to evaluate the condition. Can be LESS_THAN, EQUAL_TO or GREATER_THAN "
  default = "GREATER_THAN"
}

variable "threshold" {
  type        = string
  description = "Threshold when the notification should be sent."
  default = "80"
}

variable "threshold_type" {
  type        = string
  description = "What kind of threshold is defined. Can be PERCENTAGE OR ABSOLUTE_VALUE"
  default = "PERCENTAGE"
}

variable "notification_type" {
  type        = string
  description = "What kind of budget value to notify on. Can be ACTUAL or FORECASTED."
  default = "ACTUAL"
}

variable "subscriber_email_addresses" {
  type        = list(string)
  description = "E-Mail addresses to notify."
  default = [
    "psd@armandoalvarez.com",
    "cloudaws@armandoalvarez.com"
  ]
}

# module "control_tower_controls"
variable "ct_controls" {
  type = list(object({
    control_names           = list(string)
    organizational_unit_ids = list(string)
  }))

  description = "Configuration of AWS Control Tower Guardrails for the whole organization"
  default     = [
      {
        control_names = [
          "AWS-GR_DISALLOW_VPN_CONNECTIONS"
        ],
        # OUs that do not include the networking account: PolicyStaging, Security OU (audit & logarchive), Workloads OU, Security Tooling, etc.
        organizational_unit_ids = ["ou-ll9b-sximkjxq","ou-ll9b-qb3p5b3n"],
      },
      {
        control_names = [
          "AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS"
        ],
        # OUs: All (Disallow creation of access keys for the root user) 
        organizational_unit_ids = ["ou-ll9b-7v31mpgn","ou-ll9b-x5gljf30","ou-ll9b-sximkjxq","ou-ll9b-qb3p5b3n","ou-ll9b-2ktqapvp"],
      },
      {
        control_names = [
          "AWS-GR_RESTRICT_ROOT_USER",
        ],
        # OUs: All (Disallow actions as a root user) 
        organizational_unit_ids = ["ou-ll9b-7v31mpgn","ou-ll9b-x5gljf30","ou-ll9b-sximkjxq","ou-ll9b-qb3p5b3n","ou-ll9b-2ktqapvp"],
      }      
    ]
}