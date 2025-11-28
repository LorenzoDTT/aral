#######
# VPC
#######
data "aws_region" "current" {
}

resource "aws_vpc" "workload" {
  ipv4_ipam_pool_id    = data.aws_ssm_parameter.ipam_pool_id.value
  ipv4_netmask_length  = lookup(local.vpc_netmask, var.vpc_size)
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "vpc-${var.vpc_name}-${data.aws_region.current.region}" }
  lifecycle {
    ignore_changes = [tags]
  }
}

##########
# Subnets
##########

resource "aws_subnet" "frontend" {
  for_each          = local.vpc_sizes[var.vpc_size].frontend_subnets_cidrs
  vpc_id            = aws_vpc.workload.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags              = { Name = "frontend-${each.value.az}" }
  lifecycle {
    ignore_changes = [cidr_block, tags]
  }
}

resource "aws_subnet" "application" {
  for_each          = local.vpc_sizes[var.vpc_size].application_subnets_cidrs
  vpc_id            = aws_vpc.workload.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags              = { Name = "application-${each.value.az}" }
  lifecycle {
    ignore_changes = [cidr_block, tags]
  }
}

resource "aws_subnet" "data" {
  for_each          = local.vpc_sizes[var.vpc_size].data_subnets_cidrs
  vpc_id            = aws_vpc.workload.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags              = { Name = "data-${each.value.az}" }
  lifecycle {
    ignore_changes = [cidr_block, tags]
  }
}

resource "aws_subnet" "tgw" {
  for_each          = local.vpc_sizes[var.vpc_size].tgw_subnets_cidrs
  vpc_id            = aws_vpc.workload.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags              = { Name = "tgw-${each.value.az}" }
  lifecycle {
    ignore_changes = [cidr_block, tags]
  }
}

###############
# Route Tables
###############

resource "aws_route_table" "frontend" {
  count  = var.vpc_size == "small" || var.vpc_size == "xsmall" ? 0 : 1
  vpc_id = aws_vpc.workload.id
  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = nonsensitive(data.aws_ssm_parameter.tgw_id.value)
  }
  tags = { Name = "frontend-rtb-${var.vpc_name}" }
}

resource "aws_route_table_association" "frontend" {
  for_each       = contains(["small", "xsmall"], var.vpc_size) ? {} : aws_subnet.frontend
  subnet_id      = each.value.id
  route_table_id = aws_route_table.frontend[0].id
}

resource "aws_route_table" "application" {
  vpc_id = aws_vpc.workload.id
  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = nonsensitive(data.aws_ssm_parameter.tgw_id.value)
  }
  tags = { Name = "application-rtb-${var.vpc_name}" }
}

resource "aws_route_table_association" "application" {
  for_each       = aws_subnet.application
  subnet_id      = each.value.id
  route_table_id = aws_route_table.application.id
}

resource "aws_route_table" "data" {
  count  = var.vpc_size == "xsmall" ? 0 : 1
  vpc_id = aws_vpc.workload.id
  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = nonsensitive(data.aws_ssm_parameter.tgw_id.value)
  }
  tags = { Name = "data-rtb-${var.vpc_name}" }
}

resource "aws_route_table_association" "data" {
  for_each       = contains(["xsmall"], var.vpc_size) ? {} : aws_subnet.data
  subnet_id      = each.value.id
  route_table_id = aws_route_table.data[0].id
}

##################
# TGW Attachment
##################

resource "aws_ec2_transit_gateway_vpc_attachment" "workload" {
  subnet_ids                                      = [for subnet in aws_subnet.tgw : subnet.id]
  transit_gateway_id                              = nonsensitive(data.aws_ssm_parameter.tgw_id.value)
  vpc_id                                          = aws_vpc.workload.id
  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true
  tags                                            = { Name = "tgw-workload-vpc-attachment-${var.vpc_name}" }
  depends_on                                      = [aws_subnet.tgw]
}

###############
# DHCP Options
###############

resource "aws_vpc_dhcp_options" "workload" {
  domain_name_servers = ["AmazonProvidedDNS"]
  ntp_servers         = ["169.254.169.123"]
  tags                = { Name = "dhcp-options-${var.vpc_name}" }
}

resource "aws_vpc_dhcp_options_association" "workload" {
  vpc_id          = aws_vpc.workload.id
  dhcp_options_id = aws_vpc_dhcp_options.workload.id
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.workload.id
}

