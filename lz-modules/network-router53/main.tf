######################################################
## Route53 Private Hosted Zone and Record for NLB
######################################################
resource "aws_route53_zone" "nlb_private_zone" {
  name = var.route53_zone_name
  dynamic "vpc" {
    for_each = var.vpc_region
    content {
      vpc_region = vpc.value.vpc_region
      vpc_id     = vpc.value.vpc_id
    }
  }
}
######################################################
# aws_route53_record for NLB with weighted routing policy
#######################################################
resource "aws_route53_record" "nlb_dns" {
  depends_on     = [aws_route53_zone.nlb_private_zone]
  for_each       = { for key, value in local.nlb_record_fat : "${value.network}-${value.zone_id}-${key}" => value }
  zone_id        = aws_route53_zone.nlb_private_zone.zone_id
  set_identifier = "${each.value.routing_policy_failover}-identifier-${each.value.name}"
  name           = each.value.name
  type           = each.value.type

  alias {
    name                   = each.value.network
    zone_id                = each.value.zone_id
    evaluate_target_health = true
  }

  failover_routing_policy {
    type = each.value.routing_policy_failover
  }
}
