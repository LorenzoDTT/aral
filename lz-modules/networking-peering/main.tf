########################################
# Peering Transit Gateway Spain and USA
########################################
resource "aws_ec2_transit_gateway_peering_attachment" "peering_attachment" {
  transit_gateway_id      = var.transit_gateway_id_spain
  peer_transit_gateway_id = var.peer_transit_gateway_id_North_Virginia
  peer_account_id         = var.peer_account_id
  peer_region             = var.peer_region_North_Virginia
  tags                                 = { Name = "tgw-peering-Spain" }
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "peering_accepter" {
  provider                      = aws.us_east_1
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.peering_attachment.id
  tags                                 = { Name = "tgw-peering-North-Virginia" }
}

resource "aws_ec2_transit_gateway_route" "static_route_spain" {
  destination_cidr_block        = var.destination_cidr_block_spain
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.peering_attachment.id

  transit_gateway_route_table_id = var.tgw_route_table_id_spain
  blackhole                      = false
}

resource "aws_ec2_transit_gateway_route" "static_route_North_Virginia" {
  provider                      = aws.us_east_1
  destination_cidr_block        = var.destination_cidr_block_North_Virginia
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.peering_attachment.id

  transit_gateway_route_table_id = var.tgw_route_table_id_North_Virginia
  blackhole                      = false
}

resource "aws_ec2_transit_gateway_route" "static_route_North_Virginia_other" {
  provider                      = aws.us_east_1
  destination_cidr_block        = var.destination_cidr_block_North_Virginia_other
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.peering_attachment.id

  transit_gateway_route_table_id = var.tgw_route_table_id_North_Virginia
  blackhole                      = false
}

