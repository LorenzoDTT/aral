##################
# Variables Spain
##################

variable "transit_gateway_id_spain" {
  description = "(Required) Identifier of EC2 Transit Gateway."
  type        = string 
}

variable "destination_cidr_block_spain" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
}

variable "tgw_route_table_id_spain" {
  description = "(Required) Identifier of EC2 Transit Gateway Route Table."
  type        = string
}

variable "peer_account_id" {
  description = "(Optional) Account ID of EC2 Transit Gateway to peer with. Defaults to the account ID the AWS provider is currently connected to."
  type        = string
  default     = null
}

###########################
# Variables North Virginia
###########################

variable "peer_transit_gateway_id_North_Virginia" {
  description = "(Required) Identifier of EC2 Transit Gateway to peer with."
  type        = string
}

variable "peer_region_North_Virginia" {
  description = "(Required) Region of EC2 Transit Gateway to peer with."
  type        = string
}


variable "destination_cidr_block_North_Virginia" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
}

variable "destination_cidr_block_North_Virginia_other" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR used for destination matches. Routing decisions are based on the most specific match."
  type        = string
}

variable "tgw_route_table_id_North_Virginia" {
  description = "(Required) Identifier of EC2 Transit Gateway Route Table."
  type        = string
}

