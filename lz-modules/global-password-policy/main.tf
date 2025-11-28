 # There is only a single policy allowed per AWS account
 resource "aws_iam_account_password_policy" "corp_pwd_policy" {
  # number of previous pwds that users are prevented from reusing.
  password_reuse_prevention      = 3
  # number of days that an user pwd is valid
  max_password_age               = 90
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}