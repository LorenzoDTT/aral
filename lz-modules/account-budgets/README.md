# Introduction

This terraform module can be used as global customization or single customization in the accounts to create budgets.

This module is called in the main.tf file of the account by using lz-nameoftheaccount->main.tf

module "budgets" {
  source       = "git::codecommit::us-east-1://lz-modules.git//account-budgets"
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

Also, in the variables.tf file, you must to configure the variables you want to change, amount, mail, etc.