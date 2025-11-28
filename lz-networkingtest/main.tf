# Create breakglass admin role in the account
module "global_breakglass_admin_role" {
  source         = "github.com/LorenzoDTT/aral.git//global-admin-role"
  name           = var.name
  principal_arns = var.principal_arns
  policy_arns    = var.policy_arns
}

# Set global alernate contacts
module "alternate_contacts" {
  source         = "github.com/LorenzoDTT/aral.git//global-alternate-contacts"
  resource_sufix = "alternate-contacts"
}

# # Modulo Transit Gateway Test

# module "Transit_Gateway" {
#   source              = "github.com/LorenzoDTT/aral.git//networking-transit-gateway"
#   providers            = { 
#     aws.us_east_1 = aws.us_east_1
#   }

# ######SPAIN#####
#   amazon_side_asn_spain             = var.amazon_side_asn_spain
#   name_spain                        = var.name_spain

# ######NORTH VIRGINIA#####
#   amazon_side_asn_North_Virginia    = var.amazon_side_asn_North_Virginia
#   name_North_Virginia               = var.name_North_Virginia
# }

# Modulo VPN Test

# module "VPN" {
#   source              = "github.com/LorenzoDTT/aral.git//networking-vpn"
#   providers            = { 
#     aws.us_east_1 = aws.us_east_1
#   }
#   ######SPAIN#####
#   transit_gateway_id_spain  = module.Transit_Gateway.transit_gateway_id_spain
#   tgw_route_table_id_spain = var.tgw_route_table_id_spain

#     //Orange
#     customer_gateway_bgp_asn_orange = var.customer_gateway_bgp_asn_orange
#     customer_gateway_ip_address_orange  = var.customer_gateway_ip_address_orange
#     remote_ipv4_network_cidr_orange  = var.remote_ipv4_network_cidr_orange 
#     destination_cidr_block_orange  = var.destination_cidr_block_orange

#     //Diba
#     customer_gateway_bgp_asn_diba = var.customer_gateway_bgp_asn_diba
#     customer_gateway_ip_address_diba  = var.customer_gateway_ip_address_diba
#     remote_ipv4_network_cidr_diba =  var.remote_ipv4_network_cidr_diba 
#     destination_cidr_block_diba  = var.destination_cidr_block_diba 

#   ######NORTH VIRGINIA#####
#   transit_gateway_id_North_Virginia   = module.Transit_Gateway.transit_gateway_id_North_Virginia
#   tgw_route_table_id_North_Virginia = var.tgw_route_table_id_North_Virginia

#     # //AT&T
#     customer_gateway_bgp_asn_ATYT = var.customer_gateway_bgp_asn_ATYT
#     customer_gateway_ip_address_ATYT  = var.customer_gateway_ip_address_ATYT
#     remote_ipv4_network_cidr_ATYT  = var.remote_ipv4_network_cidr__ATYT
#     destination_cidr_block_ATYT  = var.destination_cidr_block__ATYT

#     # //Spectrum
#     customer_gateway_bgp_asn_spectrum = var.customer_gateway_bgp_asn_spectrum
#     customer_gateway_ip_address_spectrum  = var.customer_gateway_ip_address_spectrum
#     remote_ipv4_network_cidr_spectrum  = var.remote_ipv4_network_cidr_spectrum
#     destination_cidr_block_spectrum   = var.destination_cidr_block_spectrum
# }

# Modulo Peering Test

# module "Peering" {
#   source                       = "github.com/LorenzoDTT/aral.git//networking-peering"
#   providers            = { 
#     aws.us_east_1 = aws.us_east_1
#   }
# ######SPAIN#####
#   transit_gateway_id_spain     = module.Transit_Gateway.transit_gateway_id_spain
#   destination_cidr_block_spain = var.destination_cidr_block_spain
  
#   destination_cidr_block_spain_other = var.destination_cidr_block_spain_other
#   tgw_route_table_id_spain     = var.tgw_route_table_id_spain

# ######NORTH VIRGINIA#####
#   peer_transit_gateway_id_North_Virginia      = module.Transit_Gateway.transit_gateway_id_North_Virginia
#   peer_region_North_Virginia                  = var.peer_region_North_Virginia
#   destination_cidr_block_North_Virginia = var.destination_cidr_block_North_Virginia
#   destination_cidr_block_North_Virginia_other = var.destination_cidr_block_North_Virginia_other 
#   tgw_route_table_id_North_Virginia     = var.tgw_route_table_id_North_Virginia
# }