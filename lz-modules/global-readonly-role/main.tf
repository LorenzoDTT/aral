resource "aws_iam_role" "readonly_role" {
  name               = var.ro_name
  assume_role_policy = file("${path.module}/json/lz_ro_assumerole.json")
}

resource "aws_iam_role_policy_attachment" "attach_readonly_policy" {
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = aws_iam_role.readonly_role.name
}