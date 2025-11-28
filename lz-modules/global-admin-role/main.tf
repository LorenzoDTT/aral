resource "aws_iam_role" "breakglass_admin_role" {
  name               = var.name
  assume_role_policy = file("${path.module}/json/lz_admin_assumerole.json")
}

resource "aws_iam_role_policy_attachment" "attach_admin_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.breakglass_admin_role.name
}