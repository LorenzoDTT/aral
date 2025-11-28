## Local values for flattening the NLB record aliases
locals {
  nlb_record_fat = flatten([
    for record_key, record in var.record_dns_name : [
      for alias in record.type_alias != null ? record.type_alias : [] : {
        name     = record.name
        type     = record.type
        network  = alias.network
        zone_id  = alias.zone_id
        routing_policy_failover = alias.routing_policy_failover
      }
    ]
  ])
}