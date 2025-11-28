######################################
# global_breakglass_admin_role module
######################################
variable "name" {
  type        = string
  description = "The name of the role. "
  default     = "breakglass_admin"
}
variable "principal_arns" {
  type        = string
  description = "ARNs of accounts, groups, or users with the ability to assume this role."
  default     = "381491940389"
}
variable "policy_arns" {
  type        = string
  description = "List of ARNs of policies to be associated with the created IAM role"
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#########################
# transit_gateway module
#########################

# Variables Spain
variable "name_spain" {
  description = "Name Transit Gateway"
  type        = string
  default     = "tgw-Spain"
}

variable "amazon_side_asn_spain" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN."
  type        = string
  default     = "64512"
}

# Variables North Virginia
variable "name_North_Virginia" {
  description = "Name Transit Gateway"
  type        = string
  default     = "tgw-North-Virginia"
}

variable "amazon_side_asn_North_Virginia" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN."
  type        = string
  default     = "65510"
}

#############
# VPN module
#############

# Variables Spain

//Orange
variable "customer_gateway_bgp_asn_orange" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  type        = string
  default     = "65100"
}

variable "customer_gateway_ip_address_orange" {
  description = "(Optional) The IPv4 address for the customer gateway device's outside interface"
  type        = string
  default     = "62.37.193.114"
}

variable "remote_ipv4_network_cidr_orange" {
  description = "(Optional, Default 0.0.0.0/0) The IPv4 CIDR on the AWS side of the VPN connection."
  type        = string
  default     = "0.0.0.0/0"
}

variable "destination_cidr_block_orange" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
  default     = "10.57.57.192/26"
}

//Diba
variable "customer_gateway_bgp_asn_diba" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).."
  type        = string
  default     = "65200"
}

variable "customer_gateway_ip_address_diba" {
  description = "(Optional) The IPv4 address for the customer gateway device's outside interface"
  type        = string
  default     = "195.53.86.50"
}

variable "remote_ipv4_network_cidr_diba" {
  description = "(Optional, Default 0.0.0.0/0) The IPv4 CIDR on the AWS side of the VPN connection."
  type        = string
  default     = "0.0.0.0/0"
}

variable "destination_cidr_block_diba" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
  default     = "10.57.57.128/26"
}

# Variables North Virginia

//AT&T
variable "customer_gateway_bgp_asn_ATYT" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  type        = string
  default     = "65300"
}

variable "customer_gateway_ip_address_ATYT" {
  description = "(Optional) The IPv4 address for the customer gateway device's outside interface"
  type        = string
  default     = "12.76.53.106"
}

variable "remote_ipv4_network_cidr__ATYT" {
  description = "(Optional, Default 0.0.0.0/0) The IPv4 CIDR on the AWS side of the VPN connection."
  type        = string
  default     = "0.0.0.0/0"
}

variable "destination_cidr_block__ATYT" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
  default     = "10.57.16.128/26"
}

//Spectrum
variable "customer_gateway_bgp_asn_spectrum" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).."
  type        = string
  default     = "65400"
}

variable "customer_gateway_ip_address_spectrum" {
  description = "(Optional) The IPv4 address for the customer gateway device's outside interface"
  type        = string
  default     = "71.14.158.178"
}

variable "remote_ipv4_network_cidr_spectrum" {
  description = "(Optional, Default 0.0.0.0/0) The IPv4 CIDR on the AWS side of the VPN connection."
  type        = string
  default     = "0.0.0.0/0"
}

variable "destination_cidr_block_spectrum" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
  default     = "10.57.16.192/26"
}

#################
# Peering module
#################

# Variables Spain

variable "destination_cidr_block_spain" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
  default     = "10.57.16.0/24"
}

# Variables North Virginia

variable "peer_transit_gateway_id_North_Virginia" {
  description = "(Required) Identifier of EC2 Transit Gateway to peer with."
  type        = string
  default     = "tgw-003162c06e573b1a3"
}

variable "peer_region_North_Virginia" {
  description = "(Required) Region of EC2 Transit Gateway to peer with."
  type        = string
  default     = "us-east-1"
}

variable "destination_cidr_block_North_Virginia" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
  default     = "10.57.57.0/24"
}

variable "destination_cidr_block_North_Virginia_other" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
  default     = "10.60.0.0/16"
}


########################
# Direct Connect module
########################

# Variables Spain
variable "amazon_dx_side_asn_spain" {
  description = "(Required) The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294."
  type        = string
  default     = "64522"
}

variable "dx_bgp_asn_spain" {
  description = "(Required) The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration."
  type        = string
  default     = "12956"
}

variable "vlan_spain" {
  description = "(Required) The VLAN ID."
  type        = string
  default     = "125"
}

variable "bgp_auth_key_Spain" {
  description = "(Optional) The authentication key for BGP configuration."
  type        = string
  default     = "AMAZONTDESP105420"
}

variable "connection_id_Spain_Telefonica1" {
  description = "(Required) The ID of the Direct Connect connection (or LAG) on which to create the virtual interface."
  type        = string
  default     = "dxcon-fgaax5i2"
}

variable "amazon_address_Spain_Telefonica1" {
  description = "(Optional) The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers."
  type        = string
  default     = "10.31.128.10/30"
}

variable "customer_address_Spain_Telefonica1" {
  description = "(Optional) The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers."
  type        = string
  default     = "10.31.128.9/30"
}

variable "connection_id_Spain_Telefonica2" {
  description = "(Required) The ID of the Direct Connect connection (or LAG) on which to create the virtual interface."
  type        = string
  default     = "dxcon-fhbgd1jj"
}

variable "amazon_address_Spain_Telefonica2" {
  description = "(Optional) The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers."
  type        = string
  default     = "10.31.128.14/30"
}

variable "customer_address_Spain_Telefonica2" {
  description = "(Optional) The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers."
  type        = string
  default     = "10.31.128.13/30"
}

# Variables North Virginia

variable "amazon_dx_side_asn_North_Virginia" {
  description = "(Required) The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294."
  type        = string
  default     = "65512"
}

variable "dx_bgp_asn_North_Virginia" {
  description = "(Required) The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration."
  type        = string
  default     = "13979"
}

variable "vlan_North_Virginia" {
  description = "(Required) The VLAN ID."
  type        = string
  default     = "5"
}

variable "bgp_auth_key_North_Virginia" {
  description = "(Optional) The authentication key for BGP configuration."
  type        = string
  default     = "373533211019"
}

variable "connection_id_North_Virginia_ATYT1" {
  description = "(Required) The ID of the Direct Connect connection (or LAG) on which to create the virtual interface."
  type        = string
  default     = "dxcon-fh9tohae"
}

variable "amazon_address_North_Virginia_ATYT1" {
  description = "(Optional) The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers."
  type        = string
  default     = "10.254.254.98/29"
}

variable "customer_address_North_Virginia_ATYT1" {
  description = "(Optional) The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers."
  type        = string
  default     = "10.254.254.97/29"
}

variable "connection_id_North_Virginia_ATYT2" {
  description = "(Required) The ID of the Direct Connect connection (or LAG) on which to create the virtual interface."
  type        = string
  default     = "dxcon-fhd6fo75"
}

variable "amazon_address_North_Virginia_ATYT2" {
  description = "(Optional) The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers."
  type        = string
  default     = "10.254.254.106/29"
}

variable "customer_address_North_Virginia_ATYT2" {
  description = "(Optional) The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers."
  type        = string
  default     = "10.254.254.105/29"
}


####################
# generic variables
####################

# Variables Spain

variable "transit_gateway_id_spain" {
  description = "(Opcional) El ID de EC2 Transit Gateway."
  type        = string
  default     = "tgw-07dffa8eee7fdd244"
}

variable "tgw_route_table_id_spain" {
  description = "(Required) Identifier of EC2 Transit Gateway Route Table."
  type        = string
  default     = "tgw-rtb-05e3f190c7983d2c1"
}

# Variables North Virginia

variable "transit_gateway_id_North_Virginia" {
  description = "(Opcional) El ID de EC2 Transit Gateway."
  type        = string
  default     = "tgw-003162c06e573b1a3"
}

variable "tgw_route_table_id_North_Virginia" {
  description = "(Required) Identifier of EC2 Transit Gateway Route Table."
  type        = string
  default     = "tgw-rtb-0e4b25bec3fe07acd"
}