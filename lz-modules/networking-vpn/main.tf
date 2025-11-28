########################## SPAIN ##########################

##########################
# Customer Gateways Spain
##########################
resource "aws_customer_gateway" "customer_gateway_orange" { 
  bgp_asn    = var.customer_gateway_bgp_asn_orange                     
  ip_address = var.customer_gateway_ip_address_orange  
  type       = "ipsec.1"
  tags       = { Name = "cgw-orange" }
}

resource "aws_customer_gateway" "customer_gateway_diba" { 
  bgp_asn    = var.customer_gateway_bgp_asn_diba                            
  ip_address = var.customer_gateway_ip_address_diba                          
  type       = "ipsec.1"
  tags       = { Name = "cgw-diba" }
}


############
# VPN Spain
############

resource "aws_vpn_connection" "vpn_connection_orange" {
  transit_gateway_id = var.transit_gateway_id_spain  
  customer_gateway_id = aws_customer_gateway.customer_gateway_orange.id
  type               = "ipsec.1"
  static_routes_only     = true
  remote_ipv4_network_cidr   = var.remote_ipv4_network_cidr_orange 

#Tunnel1 - Orange
  tunnel1_ike_versions                 = ["ikev1"]
  tunnel1_dpd_timeout_action           = "restart"

//Tunnel1 - Phase1
  tunnel1_phase1_encryption_algorithms = ["AES256"]
  tunnel1_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase1_dh_group_numbers      = ["14"]

//Tunnel1 - Phase2
  tunnel1_phase2_encryption_algorithms = ["AES256"]
  tunnel1_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase2_dh_group_numbers      = ["14"]


#Tunnel2 - Orange
  tunnel2_ike_versions                 = ["ikev1"]
  tunnel2_dpd_timeout_action           = "restart"

//Tunnel2 - Phase1
  tunnel2_phase1_encryption_algorithms = ["AES256"]
  tunnel2_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase1_dh_group_numbers      = ["14"]

//Tunnel2 - Phase2
  tunnel2_phase2_encryption_algorithms = ["AES256"]
  tunnel2_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase2_dh_group_numbers      = ["14"]

  tags                                 = { Name = "vpn-orange" }

}


resource "aws_vpn_connection" "vpn_connection_diba" { 
  transit_gateway_id = var.transit_gateway_id_spain 
  customer_gateway_id = aws_customer_gateway.customer_gateway_diba.id 
  type               = "ipsec.1"
  static_routes_only     = true
  remote_ipv4_network_cidr   = var.remote_ipv4_network_cidr_diba



#Tunnel1 - Diba
  tunnel1_ike_versions                 = ["ikev1"]
  tunnel1_dpd_timeout_action           = "restart"

//Tunnel1 - Phase1
  tunnel1_phase1_encryption_algorithms = ["AES256"]
  tunnel1_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase1_dh_group_numbers      = ["14"]

//Tunnel1 - Phase2
  tunnel1_phase2_encryption_algorithms = ["AES256"]
  tunnel1_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase2_dh_group_numbers      = ["14"]



#Tunnel2 - Diba
  tunnel2_ike_versions                 = ["ikev1"]
  tunnel2_dpd_timeout_action           = "restart"

//Tunnel2 - Phase1
  tunnel2_phase1_encryption_algorithms = ["AES256"]
  tunnel2_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase1_dh_group_numbers      = ["14"]

//Tunnel2 - Phase2
  tunnel2_phase2_encryption_algorithms = ["AES256"]
  tunnel2_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase2_dh_group_numbers      = ["14"]


  tags                                 = { Name = "vpn-diba" }

}


##########################
# TGW - VPN  Routes Spain
##########################
resource "aws_ec2_transit_gateway_route" "tgw_spain_route_orange" {
  destination_cidr_block     = var.destination_cidr_block_orange 
  transit_gateway_route_table_id = var.tgw_route_table_id_spain
  blackhole                  = false 
  transit_gateway_attachment_id = aws_vpn_connection.vpn_connection_orange.transit_gateway_attachment_id 
}

resource "aws_ec2_transit_gateway_route" "tgw_spain_route_diba" {
  destination_cidr_block     = var.destination_cidr_block_diba 
  transit_gateway_route_table_id = var.tgw_route_table_id_spain  
  blackhole                  = false  
  transit_gateway_attachment_id = aws_vpn_connection.vpn_connection_diba.transit_gateway_attachment_id  
}

########################## NORTH VIRGINA ##########################

###################################
# Customer Gateways North virginia
###################################
resource "aws_customer_gateway" "customer_gateway_ATYT" {
  provider = aws.us_east_1
  bgp_asn    = var.customer_gateway_bgp_asn_ATYT              
  ip_address = var.customer_gateway_ip_address_ATYT
  type       = "ipsec.1"
  tags       = { Name = "cgw-AT&T" }
}

resource "aws_customer_gateway" "customer_gateway_spectrum" {
  provider = aws.us_east_1
  bgp_asn    = var.customer_gateway_bgp_asn_spectrum                            
  ip_address = var.customer_gateway_ip_address_spectrum                          
  type       = "ipsec.1"
  tags       = { Name = "cgw-spectrum" }
}


#####################
# VPN North virginia
#####################

resource "aws_vpn_connection" "vpn_connection_ATYT" {
  provider = aws.us_east_1 
  transit_gateway_id = var.transit_gateway_id_North_Virginia  
  customer_gateway_id = aws_customer_gateway.customer_gateway_ATYT.id
  type               = "ipsec.1"
  static_routes_only     = true
  remote_ipv4_network_cidr   = var.remote_ipv4_network_cidr_ATYT

#Tunnel1 - AT&T
  tunnel1_ike_versions                 = ["ikev1"]
  tunnel1_dpd_timeout_action           = "restart"

//Tunnel1 - Phase1
  tunnel1_phase1_encryption_algorithms = ["AES256"]
  tunnel1_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase1_dh_group_numbers      = ["14"]

//Tunnel1 - Phase2
  tunnel1_phase2_encryption_algorithms = ["AES256"]
  tunnel1_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase2_dh_group_numbers      = ["14"]


#Tunnel2 - AT&T
  tunnel2_ike_versions                 = ["ikev1"]
  tunnel2_dpd_timeout_action           = "restart"

//Tunnel2 - Phase1
  tunnel2_phase1_encryption_algorithms = ["AES256"]
  tunnel2_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase1_dh_group_numbers      = ["14"]

//Tunnel2 - Phase2
  tunnel2_phase2_encryption_algorithms = ["AES256"]
  tunnel2_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase2_dh_group_numbers      = ["14"]

  tags                                 = { Name = "vpn-AT&T" }

}


resource "aws_vpn_connection" "vpn_connection_spectrum" {
  provider = aws.us_east_1
  transit_gateway_id = var.transit_gateway_id_North_Virginia  
  customer_gateway_id = aws_customer_gateway.customer_gateway_spectrum.id 
  type               = "ipsec.1"
  static_routes_only     = true
  remote_ipv4_network_cidr   = var.remote_ipv4_network_cidr_spectrum 

#Tunnel1 - Spectrum
  tunnel1_ike_versions                 = ["ikev1"]
  tunnel1_dpd_timeout_action           = "restart"

//Tunnel1 - Phase1
  tunnel1_phase1_encryption_algorithms = ["AES256"]
  tunnel1_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase1_dh_group_numbers      = ["14"]

//Tunnel1 - Phase2
  tunnel1_phase2_encryption_algorithms = ["AES256"]
  tunnel1_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase2_dh_group_numbers      = ["14"]



#Tunnel2 - Spectrum
  tunnel2_ike_versions                 = ["ikev1"]
  tunnel2_dpd_timeout_action           = "restart"

//Tunnel2 - Phase1
  tunnel2_phase1_encryption_algorithms = ["AES256"]
  tunnel2_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase1_dh_group_numbers      = ["14"]

//Tunnel2 - Phase2
  tunnel2_phase2_encryption_algorithms = ["AES256"]
  tunnel2_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase2_dh_group_numbers      = ["14"]


  tags                                 = { Name = "vpn-spectrum" }

}


###################################
# TGW - VPN  Routes North Virginia
###################################
resource "aws_ec2_transit_gateway_route" "tgw_north_virginia_route_ATYT" {
  provider = aws.us_east_1 
  destination_cidr_block     = var.destination_cidr_block_ATYT
  transit_gateway_route_table_id = var.tgw_route_table_id_North_Virginia
  blackhole                  = false 
  transit_gateway_attachment_id = aws_vpn_connection.vpn_connection_ATYT.transit_gateway_attachment_id 
}

resource "aws_ec2_transit_gateway_route" "tgw_north_virginia_route_spectrum" {
  provider = aws.us_east_1
  destination_cidr_block     = var.destination_cidr_block_spectrum 
  transit_gateway_route_table_id = var.tgw_route_table_id_North_Virginia  
  blackhole                  = false  
  transit_gateway_attachment_id = aws_vpn_connection.vpn_connection_spectrum.transit_gateway_attachment_id  
}
