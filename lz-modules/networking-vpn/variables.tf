##################
# Variables Spain
##################

variable "customer_gateway_bgp_asn_orange" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  type        = string
}  

variable "customer_gateway_ip_address_orange" {
  description = "(Optional) The IPv4 address for the customer gateway device's outside interface"
  type        = string
}  

variable "customer_gateway_bgp_asn_diba" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).."
  type        = string
}  

variable "customer_gateway_ip_address_diba" {
  description = "(Optional) The IPv4 address for the customer gateway device's outside interface"
  type        = string
}  

variable "transit_gateway_id_spain" {
  description = "(Opcional) El ID de EC2 Transit Gateway."
  type        = string 
}

variable "remote_ipv4_network_cidr_orange" {
  description = "(Optional, Default 0.0.0.0/0) The IPv4 CIDR on the AWS side of the VPN connection."
  type        = string
}


variable "remote_ipv4_network_cidr_diba" {
  description = "(Optional, Default 0.0.0.0/0) The IPv4 CIDR on the AWS side of the VPN connection."
  type        = string
}

variable "tgw_route_table_id_spain" {
  description = "(Required) Identifier of EC2 Transit Gateway Route Table."
  type        = string
}

variable "destination_cidr_block_orange" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
}

variable "destination_cidr_block_diba" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
}


###########################
# Variables North Virginia
###########################

variable "customer_gateway_bgp_asn_ATYT" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  type        = string
}  

variable "customer_gateway_ip_address_ATYT" {
  description = "(Optional) The IPv4 address for the customer gateway device's outside interface"
  type        = string
}  

variable "customer_gateway_bgp_asn_spectrum" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).."
  type        = string
}  

variable "customer_gateway_ip_address_spectrum" {
  description = "(Optional) The IPv4 address for the customer gateway device's outside interface"
  type        = string
}  

variable "transit_gateway_id_North_Virginia" {
  description = "(Opcional) El ID de EC2 Transit Gateway."
  type        = string
}

variable "remote_ipv4_network_cidr_ATYT" {
  description = "(Optional, Default 0.0.0.0/0) The IPv4 CIDR on the AWS side of the VPN connection."
  type        = string
}

variable "remote_ipv4_network_cidr_spectrum" {
  description = "(Optional, Default 0.0.0.0/0) The IPv4 CIDR on the AWS side of the VPN connection."
  type        = string
}

variable "tgw_route_table_id_North_Virginia" {
  description = "(Required) Identifier of EC2 Transit Gateway Route Table."
  type        = string
}

variable "destination_cidr_block_ATYT" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
}

variable "destination_cidr_block_spectrum" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
}
