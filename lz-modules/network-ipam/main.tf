##############################
#         IPAM
##############################
resource "aws_vpc_ipam" "ipam" {
  description = "IPAM"
  dynamic "operating_regions" {
    for_each = var.ipam_regions
    content {
      region_name = operating_regions.value
    }
  }
 provider = aws.eu_south_2
}

##############################
#   Principal Region Pool
##############################
resource "aws_vpc_ipam_pool" "main" {
  description    = "Principal IPAM Pool"
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.ipam.private_default_scope_id
  #locale         = "eu-south-2"
  auto_import    = true
  provider = aws.eu_south_2
}

resource "aws_vpc_ipam_pool_cidr" "main" {
  for_each     = toset(var.principal_pool_cidr)
  ipam_pool_id = aws_vpc_ipam_pool.main.id
  cidr         = each.value
}

##############################
# SharedServices and Workloads Pools
##############################
resource "aws_vpc_ipam_pool" "ipam_pools_spain" {
  for_each                          = tomap(var.ipam_pools_spain)
  description                       = each.value.description
  address_family                    = "ipv4"
  source_ipam_pool_id               = aws_vpc_ipam_pool.main.id
  ipam_scope_id                     = aws_vpc_ipam.ipam.private_default_scope_id
  locale                            = each.value.locale
  auto_import                       = true
  allocation_min_netmask_length     = 22
  allocation_default_netmask_length = 24
  allocation_max_netmask_length     = 26
}

resource "aws_vpc_ipam_pool_cidr" "ipam_pool_cidrs_spain" {
  for_each = tomap({
    for index, value in local.cidrs_spain : value.cidr => value
  })
  ipam_pool_id = aws_vpc_ipam_pool.ipam_pools_spain[each.value.key].id
  cidr         = each.value.cidr
}

###############################
# Resource Association Manager
###############################
resource "aws_ram_resource_share" "spain" {
  for_each                  = tomap(var.ipam_pools_spain)
  name                      = "ipam-${each.key}-pool-share-spain"
  allow_external_principals = false
}
# Region Resource Associations
resource "aws_ram_resource_association" "spain" {
  for_each           = tomap(var.ipam_pools_spain)
  resource_arn       = aws_vpc_ipam_pool.ipam_pools_spain[each.key].arn
  resource_share_arn = aws_ram_resource_share.spain[each.key].arn
}
# Resource Principal Associations
resource "aws_ram_principal_association" "spain" {
  for_each = tomap({
    for index, value in local.ram_workloads_spain : value.ram_workloads => value
  })
  principal          = "arn:aws:organizations::${each.value.management_account_id}:ou/${each.value.organizations_id}/${each.value.ram_workloads}"
  resource_share_arn = aws_ram_resource_share.spain[each.value.key].arn
}
##############################
#         SSM PARAMETER
##############################
resource "aws_ssm_parameter" "spain" {
  for_each    = tomap(var.ipam_pools_spain)
  name        = "/ipam/pool/${each.key}"
  description = "IPAM ${each.key} Pool ID"
  type        = "String"
  value       = aws_vpc_ipam_pool.ipam_pools_spain[each.key].id
}

###############################
# IPAM VIRGINIA
###############################
resource "aws_vpc_ipam_pool" "ipam_pools_virginia" {
  for_each                          = tomap(var.ipam_pools_virginia)
  description                       = each.value.description
  address_family                    = "ipv4"
  source_ipam_pool_id               = aws_vpc_ipam_pool.main.id
  ipam_scope_id                     = aws_vpc_ipam.ipam.private_default_scope_id
  locale                            = each.value.locale
  auto_import                       = true
  allocation_min_netmask_length     = 22
  allocation_default_netmask_length = 24
  allocation_max_netmask_length     = 26
}

resource "aws_vpc_ipam_pool_cidr" "ipam_pool_cidrs_virginia" {
  for_each = tomap({
    for index, value in local.cidrs_virginia : value.cidr => value
  })
  ipam_pool_id = aws_vpc_ipam_pool.ipam_pools_virginia[each.value.key].id
  cidr         = each.value.cidr
}

###############################
# Resource Association Manager
###############################
resource "aws_ram_resource_share" "virginia" {
  for_each                  = tomap(var.ipam_pools_virginia)
  name                      = "ipam-${each.key}-pool-share-virginia"
  allow_external_principals = false
}
# Region Resource Associations
resource "aws_ram_resource_association" "virginia" {
  for_each           = tomap(var.ipam_pools_virginia)
  resource_arn       = aws_vpc_ipam_pool.ipam_pools_virginia[each.key].arn
  resource_share_arn = aws_ram_resource_share.virginia[each.key].arn
}
# Resource Principal Associations
resource "aws_ram_principal_association" "virginia" {
  for_each = tomap({
    for index, value in local.ram_workloads_virginia : value.ram_workloads => value
  })
  principal          = "arn:aws:organizations::${each.value.management_account_id}:ou/${each.value.organizations_id}/${each.value.ram_workloads}"
  resource_share_arn = aws_ram_resource_share.virginia[each.value.key].arn
}
##############################
#         SSM PARAMETER
##############################
resource "aws_ssm_parameter" "virginia" {
  for_each    = tomap(var.ipam_pools_virginia)
  name        = "/ipam/pool/${each.key}"
  description = "IPAM ${each.key} Pool ID"
  type        = "String"
  value       = aws_vpc_ipam_pool.ipam_pools_virginia[each.key].id
  provider    = aws.us_east_1
}

##############################
# resource Principal Associations
##############################
resource "aws_vpc_ipam_pool_cidr_allocation" "sap_rise" {
  ipam_pool_id = aws_vpc_ipam_pool.ipam_pools_spain["production"].id
  cidr         = "10.60.0.0/22"
  description  = "SAP RISE reserved pool"
  provider     = aws.eu_south_2
}
