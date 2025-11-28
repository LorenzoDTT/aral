########################## SPAIN ##########################

resource "aws_dx_gateway" "dx_gateway_Spain_Telefonica1" {
  name            = "DirectConnectTFN1"
  amazon_side_asn = var.amazon_dx_side_asn_spain
}

resource "aws_dx_gateway" "dx_gateway_Spain_Telefonica2" {
  name            = "DirectConnectTFN2"
  amazon_side_asn = var.amazon_dx_side_asn_spain
}

resource "aws_dx_gateway_association" "dx_gateway_association_Spain_Telefonica1" {
  dx_gateway_id         = aws_dx_gateway.dx_gateway_Spain_Telefonica1.id
  associated_gateway_id = var.transit_gateway_id_spain

  allowed_prefixes = [
    "10.60.0.0/16",
    "10.57.16.0/24",
  ]
}

resource "aws_dx_gateway_association" "dx_gateway_association_Spain_Telefonica2" {
  dx_gateway_id         = aws_dx_gateway.dx_gateway_Spain_Telefonica2.id
  associated_gateway_id = var.transit_gateway_id_spain

  allowed_prefixes = [
    "10.60.0.0/16",
    "10.57.16.0/24",
  ]
}


resource "aws_dx_transit_virtual_interface" "dx_transit_virtual_interface_Spain_Telefonica1" {
  provider         = aws.eu_central_1
  address_family   = "ipv4"
  bgp_asn          = var.dx_bgp_asn_spain
  connection_id    = var.connection_id_Spain_Telefonica1
  dx_gateway_id    = aws_dx_gateway.dx_gateway_Spain_Telefonica1.id
  name             = "VirtIntSpain1"
  vlan             = var.vlan_spain
  bgp_auth_key     = var.bgp_auth_key_Spain
  amazon_address   = var.amazon_address_Spain_Telefonica1
  customer_address = var.customer_address_Spain_Telefonica1

  tags = { Name = "dx-vif-Telefonica1" }
}

resource "aws_dx_transit_virtual_interface" "dx_transit_virtual_interface_Spain_Telefonica2" {
  provider         = aws.eu_central_1
  address_family   = "ipv4"
  bgp_asn          = var.dx_bgp_asn_spain
  connection_id    = var.connection_id_Spain_Telefonica2
  dx_gateway_id    = aws_dx_gateway.dx_gateway_Spain_Telefonica2.id
  name             = "VirtIntSpain2"
  vlan             = var.vlan_spain
  bgp_auth_key     = var.bgp_auth_key_Spain
  amazon_address   = var.amazon_address_Spain_Telefonica2
  customer_address = var.customer_address_Spain_Telefonica2

  tags = { Name = "dx-vif-Telefonica2" }
}

########################## NORTH VIRGINA ##########################

resource "aws_dx_gateway" "dx_gateway_North_Virginia_ATYT1" {
  name            = "DirectConnectATT1"
  amazon_side_asn = var.amazon_dx_side_asn_North_Virginia
}

resource "aws_dx_gateway" "dx_gateway_North_Virginia_ATYT2" {
  name            = "DirectConnectATT2"
  amazon_side_asn = var.amazon_dx_side_asn_North_Virginia
}

resource "aws_dx_gateway_association" "dx_gateway_association_North_Virginia_ATYT1" {
  provider = aws.us_east_1

  dx_gateway_id         = aws_dx_gateway.dx_gateway_North_Virginia_ATYT1.id
  associated_gateway_id = var.transit_gateway_id_North_Virginia

  allowed_prefixes = [
    "10.60.0.0/16"
  ]
}

resource "aws_dx_gateway_association" "dx_gateway_association_North_Virginia_ATYT2" {
  provider = aws.us_east_1

  dx_gateway_id         = aws_dx_gateway.dx_gateway_North_Virginia_ATYT2.id
  associated_gateway_id = var.transit_gateway_id_North_Virginia

  allowed_prefixes = [
    "10.60.0.0/16"
  ]
}

resource "aws_dx_transit_virtual_interface" "dx_transit_virtual_interface_North_Virginia_ATYT1" {
  provider         = aws.us_east_1
  address_family   = "ipv4"
  bgp_asn          = var.bgp_asn_North_Virginia
  bgp_auth_key     = var.bgp_auth_key_North_Virginia
  connection_id    = var.connection_id_North_Virginia_ATYT1
  dx_gateway_id    = aws_dx_gateway.dx_gateway_North_Virginia_ATYT1.id
  name             = "VirtInt1"
  vlan             = var.vlan_North_Virginia
  amazon_address   = var.amazon_address_North_Virginia_ATYT1
  customer_address = var.customer_address_North_Virginia_ATYT1

  tags = { Name = "dx-vif-ATYT1" }
}

resource "aws_dx_transit_virtual_interface" "dx_transit_virtual_interface_North_Virginia_ATYT2" {
  provider         = aws.us_east_1
  address_family   = "ipv4"
  bgp_asn          = var.bgp_asn_North_Virginia
  bgp_auth_key     = var.bgp_auth_key_North_Virginia
  connection_id    = var.connection_id_North_Virginia_ATYT2
  dx_gateway_id    = aws_dx_gateway.dx_gateway_North_Virginia_ATYT2.id
  name             = "VirtInt2"
  vlan             = var.vlan_North_Virginia
  amazon_address   = var.amazon_address_North_Virginia_ATYT2
  customer_address = var.customer_address_North_Virginia_ATYT2

  tags = { Name = "dx-vif-ATYT2" }
}




