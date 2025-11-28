resource "aws_iam_role" "lz_deployment" {
  name               = var.deployment_name
  assume_role_policy = file("${path.module}/json/lz_deployment_assumerole.json")
}

resource "aws_iam_role_policy_attachment" "attach_admin_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.lz_deployment.name
}