locals {
  ram_workloads_spain = flatten([
    for key, value in var.ipam_pools_spain : [
      for ram in value.ram_workloads : {
        key                   = key
        management_account_id = value.management_account_id
        organizations_id      = value.organizations_id
        ram_workloads         = ram
      }
    ]
  ])
  cidrs_spain = flatten([
    for key, value in var.ipam_pools_spain : [
      for cidr in value.cidr : {
        key  = key
        cidr = cidr
      }
    ]
  ])
    ram_workloads_virginia = flatten([
    for key, value in var.ipam_pools_virginia : [
      for ram in value.ram_workloads : {
        key                   = key
        management_account_id = value.management_account_id
        organizations_id      = value.organizations_id
        ram_workloads         = ram
      }
    ]
  ])
  cidrs_virginia = flatten([
    for key, value in var.ipam_pools_virginia : [
      for cidr in value.cidr : {
        key  = key
        cidr = cidr
      }
    ]
  ])
}