# NLB for Direct Connect connections in SPAIN
module "network_load_balancer_dx_spain" {
  source = "github.com/LorenzoDTT/aral//network-loadbalancer"

  ### Network Load Balancer Module
  naming      = "printer-dx-spain"
  subnets     = ["subnet-05d725f51d4f7b967", "subnet-0726407eb965a43af"]
  environment = "pro"
  vpc_id      = "vpc-037ee407ccab16603" # For security group association

  tags = {
    Project = "NetworkLoadBalancerModule-spain"
  }
  # Configuración de listeners para el NLB
  lb_listeners = {
    dx-515-spain = {
      vpc_id   = "vpc-037ee407ccab16603"
      port     = 515
      protocol = "TCP"
      target_group = [
        {
          target_ip = "10.57.57.13"
          port      = 515
        }
      ]
    }
  }
}
## NLB for VPN connections in SPAIN
module "network_load_balancer_vpn_spain" {
  source = "github.com/LorenzoDTT/aral//network-loadbalancer"

  ### Network Load Balancer Module
  naming      = "printer-vpn-spain"
  subnets     = ["subnet-05d725f51d4f7b967", "subnet-0726407eb965a43af"]
  environment = "pro"
  vpc_id      = "vpc-037ee407ccab16603"

  tags = {
    Project = "NetworkLoadBalancerModule"
  }
  # Configuración de listeners para el NLB
  lb_listeners = {
    vpn-515-spain = {
      vpc_id   = "vpc-037ee407ccab16603"
      port     = 515
      protocol = "TCP"
      target_group = [
        {
          target_ip = "10.57.57.141" # ATT
          port      = 515
        },
        {
          target_ip = "10.57.57.205" # Spectrum
          port      = 515
        }
      ]
    }
  }
}
