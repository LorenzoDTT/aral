# Route53 Private Hosted Zone and Records for NLB
module "router53_nlb" {
  source = "git::codecommit::us-east-1://lz-modules.git//network-router53"

  ## configuración de Route53 privada
  route53_zone_name = "armandoalvarez.cloud"
  vpc_region = [
    {
      vpc_region = "eu-south-2",
      vpc_id     = "vpc-037ee407ccab16603"
    }
  ]

  # Configuración de registros DNS 
  record_dns_name = {
    nlb-printers-usa = {
      name = "printserver-usa.armandoalvarez.cloud"
      type = "A"
      type_alias = [
        {
          network                 = module.network_load_balancer_dx_usa.nlb_dns_name
          zone_id                 = module.network_load_balancer_dx_usa.nlb_zone_id
          routing_policy_failover = "PRIMARY"
        },
        {
          network                 = module.network_load_balancer_vpn_usa.nlb_dns_name
          zone_id                 = module.network_load_balancer_vpn_usa.nlb_zone_id
          routing_policy_failover = "SECONDARY"
        }
      ]
    },
    nlb-printers-spain = {
      name = "printserver-spain.armandoalvarez.cloud"
      type = "A"
      type_alias = [
        {
          network                 = module.network_load_balancer_dx_spain.nlb_dns_name
          zone_id                 = module.network_load_balancer_dx_spain.nlb_zone_id
          routing_policy_failover = "PRIMARY"
        },
        {
          network                 = module.network_load_balancer_vpn_spain.nlb_dns_name
          zone_id                 = module.network_load_balancer_vpn_spain.nlb_zone_id
          routing_policy_failover = "SECONDARY"
        }
      ]
    }
  }
}