resource "aws_vpc_endpoint" "s3_vpcendpoint_gateway" {
  count        = var.create_s3_gwvpce ? 1 : 0
  vpc_id       = aws_vpc.workload.id
  service_name = "com.amazonaws.${data.aws_region.context.region}.s3"
  route_table_ids = compact(flatten([
    aws_route_table.frontend[*].id,
    aws_route_table.data[*].id,
    [aws_route_table.application.id]
  ]))
  tags = { Name = "com.amazonaws.${data.aws_region.context.region}.s3" }
}