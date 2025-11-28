variable "description" {
    default        = "Transit Gateway creado con Terraform"
}

variable "tags" {
    description = "Tags for Transit Gateway"
    type        = map(string) 
    default     = {}  
}

variable "timeouts" {
  description = "Create, update, and delete timeout configurations for the transit gateway"
  type        = map(string)
  default     = {}
}

variable "tgw_tags" {
  description = "Additional tags for the TGW"
  type        = map(string)
  default     = {}
}

variable "enable_auto_accept_shared_attachments" {
  description = "Whether resource attachment requests are automatically accepted"
  type        = string
  default     = "enable"
}

##################
# Variables Spain
##################

variable "name_spain" {
    description = "Name Transit Gateway"
}

variable "amazon_side_asn_spain" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN."
  type        = string
}

###########################
# Variables North Virginia
###########################

variable "name_North_Virginia" {
    description = "Name Transit Gateway"
}


variable "amazon_side_asn_North_Virginia" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN."
  type        = string
}


# External Accounts

variable "sap_account_id" {
  type    = string
  default = "851725467425"
}
