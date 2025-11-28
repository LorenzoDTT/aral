resource "aws_ec2_transit_gateway" "transit_gateway_Spain" {
  description                     = coalesce(var.description, var.name_spain)
  amazon_side_asn                 = var.amazon_side_asn_spain
  auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments


  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }

  tags = merge(
    var.tags,
    { Name = var.name_spain },
    var.tgw_tags,
  )
}

resource "aws_ec2_transit_gateway" "transit_gateway_North_Virginia" {

  provider = aws.us_east_1

  description                     = coalesce(var.description, var.name_North_Virginia)
  amazon_side_asn                 = var.amazon_side_asn_North_Virginia
  auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments


  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }

  tags = merge(
    var.tags,
    { Name = var.name_North_Virginia },
    var.tgw_tags,
  )
}

###############################
# Resource Association Manager
###############################

resource "aws_ram_resource_share" "transit_gateway_Spain" {
  name                      = "transit_gateway_Spain-shr"
  allow_external_principals = true
}

resource "aws_ram_resource_association" "transit_gateway_Spain" {
  resource_arn       = aws_ec2_transit_gateway.transit_gateway_Spain.arn
  resource_share_arn = aws_ram_resource_share.transit_gateway_Spain.arn
}


####################
# External Accounts
####################

resource "aws_ram_principal_association" "sap" {
  principal          = var.sap_account_id
  resource_share_arn = aws_ram_resource_share.transit_gateway_Spain.arn
}


resource "aws_ssm_parameter" "tgw_spain_id" {
  name        = "/tgw/id/spain"
  description = "TGW Spain ARN"
  type        = "String"
  value       = aws_ec2_transit_gateway.transit_gateway_Spain.id
}

resource "aws_ssm_parameter" "tgw_virginia_id" {
  provider    = aws.us_east_1
  name        = "/tgw/id/north-virginia"
  description = "TGW North Virginia ARN"
  type        = "String"
  value       = aws_ec2_transit_gateway.transit_gateway_North_Virginia.id
}
