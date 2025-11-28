
variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "user_name" {
  description = "Nombre del usuario IAM"
  type        = string
}

variable "attach_policy_arns" {
  description = "Lista de arns de políticas para adjuntar al usuario IAM"
  type        = list(string)
}