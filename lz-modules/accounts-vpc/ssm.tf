resource "aws_ssm_parameter" "vpc_id" {
  name        = "/vpc/${var.vpc_name}/id"
  description = "The Workload VPC ID"
  type        = "String"
  value       = aws_vpc.workload.id
}

resource "aws_ssm_parameter" "frontend_subnet_id" {
  count       = var.vpc_size == "small" || var.vpc_size == "xsmall" ? 0 : 1
  name        = "/vpc/subnet/${var.vpc_name}/frontend/ids"
  description = "The Workload Frontend Subnet IDs"
  type        = "StringList"
  value       = join(",", [for subnet in aws_subnet.frontend : subnet.id])
}

resource "aws_ssm_parameter" "application_subnet_id" {
  name        = "/vpc/subnet/${var.vpc_name}/application/ids"
  description = "The Workload Application Subnet IDs"
  type        = "StringList"
  value       = join(",", [for subnet in aws_subnet.application : subnet.id])
}

resource "aws_ssm_parameter" "data_subnet_id" {
  count       = var.vpc_size == "xsmall" ? 0 : 1
  name        = "/vpc/subnet/${var.vpc_name}/data/ids"
  description = "The Workload Data Subnet IDs"
  type        = "StringList"
  value       = join(",", [for subnet in aws_subnet.data : subnet.id])
}
