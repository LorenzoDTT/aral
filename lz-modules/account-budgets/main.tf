resource "aws_budgets_budget" "monthly_budget" {
  name        = var.budget_name
  budget_type = var.budget_type
  limit_amount = var.limit_amount
  limit_unit        = "USD"
  time_unit = var.time_unit
  time_period_end   = var.time_period_end
  time_period_start = var.time_period_start

  cost_types {
    include_credit = false
    include_discount = false
    include_other_subscription = false
    include_recurring = false
    include_refund = false
    include_subscription = false
    include_support = false
    include_tax = false
    include_upfront = false
    use_blended = false
    use_amortized = false
  }

  notification {
    comparison_operator = var.comparison_operator
    threshold           = var.threshold 
    threshold_type      = var.threshold_type
    notification_type = var.notification_type
    subscriber_email_addresses = var.subscriber_email_addresses
  }
}