# Create breakglass admin role in the account
module "global_breakglass_admin_role" {
  source         = "github.com/LorenzoDTT/aral//global-admin-role"
  name           = var.name
  principal_arns = var.principal_arns
  policy_arns    = var.policy_arns
}

# Security configurations to apply at account level in all LZ accounts
# Pattern 1: Block Public Access in S3 service at account level
# You can add more security configurations in AWS by the use of this module
module "lz_security_baseline" {
  source = "github.com/LorenzoDTT/aral//global-security-baseline"
}


# Set global alernate contacts
module "alternate_contacts" {
  source         = "github.com/LorenzoDTT/aral//global-alternate-contacts"
  resource_sufix = "alternate-contacts"
}

# Modulo transit Gateway
module "Transit_Gateway" {
  source = "github.com/LorenzoDTT/aral//networking-transit-gateway"
  providers = {
    aws.us_east_1 = aws.us_east_1
  }

  ######SPAIN#####
  amazon_side_asn_spain = var.amazon_side_asn_spain
  name_spain            = var.name_spain

  ######NORTH VIRGINIA#####
  amazon_side_asn_North_Virginia = var.amazon_side_asn_North_Virginia
  name_North_Virginia            = var.name_North_Virginia
}


module "VPN" {
  source = "github.com/LorenzoDTT/aral//networking-vpn"
  providers = {
    aws.us_east_1 = aws.us_east_1
  }
  ######SPAIN#####
  transit_gateway_id_spain = module.Transit_Gateway.transit_gateway_id_spain
  tgw_route_table_id_spain = var.tgw_route_table_id_spain

  //Orange
  customer_gateway_bgp_asn_orange    = var.customer_gateway_bgp_asn_orange
  customer_gateway_ip_address_orange = var.customer_gateway_ip_address_orange
  remote_ipv4_network_cidr_orange    = var.remote_ipv4_network_cidr_orange
  destination_cidr_block_orange      = var.destination_cidr_block_orange

  //Diba
  customer_gateway_bgp_asn_diba    = var.customer_gateway_bgp_asn_diba
  customer_gateway_ip_address_diba = var.customer_gateway_ip_address_diba
  remote_ipv4_network_cidr_diba    = var.remote_ipv4_network_cidr_diba
  destination_cidr_block_diba      = var.destination_cidr_block_diba

  ######NORTH VIRGINIA#####
  transit_gateway_id_North_Virginia = module.Transit_Gateway.transit_gateway_id_North_Virginia
  tgw_route_table_id_North_Virginia = var.tgw_route_table_id_North_Virginia

  # //AT&T
  customer_gateway_bgp_asn_ATYT    = var.customer_gateway_bgp_asn_ATYT
  customer_gateway_ip_address_ATYT = var.customer_gateway_ip_address_ATYT
  remote_ipv4_network_cidr_ATYT    = var.remote_ipv4_network_cidr__ATYT
  destination_cidr_block_ATYT      = var.destination_cidr_block__ATYT

  # //Spectrum
  customer_gateway_bgp_asn_spectrum    = var.customer_gateway_bgp_asn_spectrum
  customer_gateway_ip_address_spectrum = var.customer_gateway_ip_address_spectrum
  remote_ipv4_network_cidr_spectrum    = var.remote_ipv4_network_cidr_spectrum
  destination_cidr_block_spectrum      = var.destination_cidr_block_spectrum
}

module "Peering" {
  source = "github.com/LorenzoDTT/aral//networking-peering"
  providers = {
    aws.us_east_1 = aws.us_east_1
  }
  ######SPAIN#####
  transit_gateway_id_spain     = module.Transit_Gateway.transit_gateway_id_spain
  destination_cidr_block_spain = var.destination_cidr_block_spain
  tgw_route_table_id_spain     = var.tgw_route_table_id_spain

  ######NORTH VIRGINIA#####
  peer_transit_gateway_id_North_Virginia      = module.Transit_Gateway.transit_gateway_id_North_Virginia
  peer_region_North_Virginia                  = var.peer_region_North_Virginia
  destination_cidr_block_North_Virginia       = var.destination_cidr_block_North_Virginia
  destination_cidr_block_North_Virginia_other = var.destination_cidr_block_North_Virginia_other
  tgw_route_table_id_North_Virginia           = var.tgw_route_table_id_North_Virginia
}

module "Direct_Connect" {
  source = "github.com/LorenzoDTT/aral//networking-direct-connect"
  providers = {
    aws.us_east_1    = aws.us_east_1,
    aws.eu_central_1 = aws.eu_central_1,
  }

  ######SPAIN#####
  amazon_dx_side_asn_spain = var.amazon_dx_side_asn_spain
  transit_gateway_id_spain = var.transit_gateway_id_spain
  dx_bgp_asn_spain         = var.dx_bgp_asn_spain
  vlan_spain               = var.vlan_spain
  bgp_auth_key_Spain       = var.bgp_auth_key_Spain

  connection_id_Spain_Telefonica1    = var.connection_id_Spain_Telefonica1
  amazon_address_Spain_Telefonica1   = var.amazon_address_Spain_Telefonica1
  customer_address_Spain_Telefonica1 = var.customer_address_Spain_Telefonica1

  connection_id_Spain_Telefonica2    = var.connection_id_Spain_Telefonica2
  amazon_address_Spain_Telefonica2   = var.amazon_address_Spain_Telefonica2
  customer_address_Spain_Telefonica2 = var.customer_address_Spain_Telefonica2

  ######NORTH VIRGINIA#####
  transit_gateway_id_North_Virginia = module.Transit_Gateway.transit_gateway_id_North_Virginia
  amazon_dx_side_asn_North_Virginia = var.amazon_dx_side_asn_North_Virginia
  bgp_asn_North_Virginia            = var.dx_bgp_asn_North_Virginia
  vlan_North_Virginia               = var.vlan_North_Virginia
  bgp_auth_key_North_Virginia       = var.bgp_auth_key_North_Virginia

  connection_id_North_Virginia_ATYT1    = var.connection_id_North_Virginia_ATYT1
  amazon_address_North_Virginia_ATYT1   = var.amazon_address_North_Virginia_ATYT1
  customer_address_North_Virginia_ATYT1 = var.customer_address_North_Virginia_ATYT1

  connection_id_North_Virginia_ATYT2    = var.connection_id_North_Virginia_ATYT2
  amazon_address_North_Virginia_ATYT2   = var.amazon_address_North_Virginia_ATYT2
  customer_address_North_Virginia_ATYT2 = var.customer_address_North_Virginia_ATYT2
}


########################## IPAM POOLS ##########################
module "network_ipam" {
  source = "github.com/LorenzoDTT/aral//network-ipam"

  ipam_regions        = ["eu-south-2", "us-east-1"]
  principal_pool_cidr = ["10.60.0.0/17", "10.60.128.0/17"]

  ipam_pools_spain = {
    development = {
      description           = "Development Pool Spain"
      locale                = "eu-south-2"
      cidr                  = ["10.60.64.0/19"]
      management_account_id = "792028445677"
      organizations_id      = "o-qmmwq78h0q"
      ram_workloads         = ["ou-ll9b-qj8o0ik2", "ou-ll9b-tcnv072w"] # OU DEV - Workloads and Infrastructure
    },
    preproduction = {
      description           = "Preproduction Pool Spain"
      locale                = "eu-south-2"
      cidr                  = ["10.60.32.0/19"]
      management_account_id = "792028445677"
      organizations_id      = "o-qmmwq78h0q"
      ram_workloads         = ["ou-ll9b-aczfkl5c"] # OU PREPRO - Workloads
    },
    production = {
      description           = "Production Pool Spain"
      locale                = "eu-south-2"
      cidr                  = ["10.60.0.0/19"]
      management_account_id = "792028445677"
      organizations_id      = "o-qmmwq78h0q"
      ram_workloads         = ["ou-ll9b-3kc0g1fq", "ou-ll9b-hli737k6"] # OU PROD - Workloads and Infrastructure
    },
    sharedservices = {
      description           = "SharedServices Pool Spain"
      locale                = "eu-south-2"
      cidr                  = ["10.60.96.0/19"]
      management_account_id = "792028445677"
      organizations_id      = "o-qmmwq78h0q"
      ram_workloads         = ["ou-ll9b-7v31mpgn"] # OU PRO - SharedServices
    }

  }
  ipam_pools_virginia = {
    development = {
      description           = "Development Pool Virginia"
      locale                = "us-east-1"
      cidr                  = ["10.60.192.0/19"]
      management_account_id = "792028445677"
      organizations_id      = "o-qmmwq78h0q"
      ram_workloads         = ["ou-ll9b-qj8o0ik2", "ou-ll9b-tcnv072w"] # OU DEV - Workloads and Infrastructure
    },
    preproduction = {
      description           = "Preproduction Pool Virginia"
      locale                = "us-east-1"
      cidr                  = ["10.60.160.0/19"]
      management_account_id = "792028445677"
      organizations_id      = "o-qmmwq78h0q"
      ram_workloads         = ["ou-ll9b-aczfkl5c"] # OU PREPRO - Workloads 
    },
    production = {
      description           = "Production Pool Virginia"
      locale                = "us-east-1"
      cidr                  = ["10.60.128.0/19"]
      management_account_id = "792028445677"
      organizations_id      = "o-qmmwq78h0q"
      ram_workloads         = ["ou-ll9b-3kc0g1fq", "ou-ll9b-hli737k6"] # OU PROD - Workloads and Infrastructure
    },
    sharedservices = {
      description           = "SharedServices Pool Virginia"
      locale                = "us-east-1"
      cidr                  = ["10.60.224.0/19"]
      management_account_id = "792028445677"
      organizations_id      = "o-qmmwq78h0q"
      ram_workloads         = ["ou-ll9b-7v31mpgn"] # OU PRO - SharedServices
    }
  }

  providers = {
    aws.eu_south_2 = aws.eu_south_2
    aws.us_east_1  = aws.us_east_1
  }
}

module "transit_vpc_sharedservices" {
  source = "github.com/LorenzoDTT/aral//accounts-vpc"

  vpc_name                        = "transit-vpc-small"
  vpc_size                        = "small"
  environment                     = "shr"
  availability_zones              = ["eu-south-2a", "eu-south-2b"]
  create_s3_gwvpce                = true
  create_route53_resolver_inbound = true
  providers = {
    aws.sharedservices = aws.eu_south_2
  }
}
