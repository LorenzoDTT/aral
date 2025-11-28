##########################################
# Route53 - Revolver inbound  
##########################################
resource "aws_security_group" "r53_resolver_inbound" {
  count       = var.create_route53_resolver_inbound ? 1 : 0
  name        = "route53_resolver_inbound"
  description = "Security group for Route53 Resolver inbound"
  vpc_id      = aws_vpc.workload.id

  ingress {
    description = "Inbound DNS queries"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "Inbound DNS queries"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "resolver-inbound-endpoints"
  }
}
resource "aws_route53_resolver_endpoint" "inbound" {
  count                  = var.create_route53_resolver_inbound ? 1 : 0
  name                   = "armando-alvarez-inbound-resolver"
  direction              = "INBOUND"
  resolver_endpoint_type = "IPV4"
  security_group_ids     = [aws_security_group.r53_resolver_inbound.0.id]
  protocols              = ["Do53"]

  dynamic "ip_address" {
    for_each = aws_subnet.data
    content {
      subnet_id = ip_address.value.id
    }
  }
}