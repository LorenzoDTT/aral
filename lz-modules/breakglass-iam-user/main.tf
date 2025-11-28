resource "aws_iam_user" "breakglass_admin_user" {
  name = var.user_name
  path          = "/"
  force_destroy = true
}

resource "aws_iam_access_key" "console_user_access_key" {
  user = aws_iam_user.breakglass_admin_user.name
}

resource "aws_iam_user_policy_attachment" "attach_policies" {
  count = length(var.attach_policy_arns)
  user       = aws_iam_user.breakglass_admin_user.name
  policy_arn = var.attach_policy_arns[count.index]
}
