output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.workload.id
}

output "frontend_subnet_id" {
  description = "The ID of the frontend subnet"
  value       = [for subnet in aws_subnet.frontend : subnet.id]
}

output "application_subnet_id" {
  description = "The ID of the application subnet"
  value       = [for subnet in aws_subnet.application : subnet.id]
}

output "data_subnet_id" {
  description = "The ID of the data subnet"
  value       = [for subnet in aws_subnet.data : subnet.id]
}
output "routeroute_table_frontend_id" {
  description = "The ID of the frontend route table"
  value       = one(aws_route_table.frontend[*].id)
}

output "aws_router_table_application_id" {
  description = "The ID of the application route table"
  value       = aws_route_table.application.id
}

output "aws_router_table_data_id" {
  description = "The ID of the data route table"
  value       = one(aws_route_table.data[*].id)
}
