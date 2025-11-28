##################
# Variables Spain
##################
variable "amazon_dx_side_asn_spain" {
  description = "(Required) The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294."
  type        = string
}

variable "transit_gateway_id_spain" {
  description = "(Optional) The ID of the VGW or transit gateway with which to associate the Direct Connect gateway. Used for single account Direct Connect gateway associations."
  type        = string
}

variable "dx_bgp_asn_spain" {
  description = "(Required) The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration."
  type        = string
}

variable "vlan_spain" {
  description = "(Required) The VLAN ID."
  type        = string
}

variable "bgp_auth_key_Spain" {
  description = "(Optional) The authentication key for BGP configuration."
  type        = string
}

variable "connection_id_Spain_Telefonica1" {
  description = "(Required) The ID of the Direct Connect connection (or LAG) on which to create the virtual interface."
  type        = string
}


variable "amazon_address_Spain_Telefonica1" {
  description = "(Optional) The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers."
  type        = string
}

variable "customer_address_Spain_Telefonica1" {
  description = "(Optional) The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers."
  type        = string
}

variable "connection_id_Spain_Telefonica2" {
  description = "(Required) The ID of the Direct Connect connection (or LAG) on which to create the virtual interface."
  type        = string
}

variable "amazon_address_Spain_Telefonica2" {
  description = "(Optional) The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers."
  type        = string
}

variable "customer_address_Spain_Telefonica2" {
  description = "(Optional) The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers."
  type        = string
}


###########################
# Variables North Virginia
###########################

variable "amazon_dx_side_asn_North_Virginia" {
  description = "(Required) The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294."
  type        = string
}

variable "transit_gateway_id_North_Virginia" {
  description = "(Optional) The ID of the VGW or transit gateway with which to associate the Direct Connect gateway. Used for single account Direct Connect gateway associations."
  type        = string
}

variable "bgp_asn_North_Virginia" {
  description = "(Required) The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration."
  type        = string
}

variable "vlan_North_Virginia" {
  description = "(Required) The VLAN ID."
  type        = string
}

variable "bgp_auth_key_North_Virginia" {
  description = "(Optional) The authentication key for BGP configuration."
  type        = string
}

variable "connection_id_North_Virginia_ATYT1" {
  description = "(Required) The ID of the Direct Connect connection (or LAG) on which to create the virtual interface."
  type        = string
}

variable "amazon_address_North_Virginia_ATYT1" {
  description = "(Optional) The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers."
  type        = string
}

variable "customer_address_North_Virginia_ATYT1" {
  description = "(Optional) The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers."
  type        = string
}

variable "connection_id_North_Virginia_ATYT2" {
  description = "(Required) The ID of the Direct Connect connection (or LAG) on which to create the virtual interface."
  type        = string
}

variable "amazon_address_North_Virginia_ATYT2" {
  description = "(Optional) The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers."
  type        = string
}

variable "customer_address_North_Virginia_ATYT2" {
  description = "(Optional) The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers."
  type        = string
}  