# NLB for Direct Connect connections in USA
module "network_load_balancer_dx_usa" {
  source = "git::https://github.com/LorenzoDTT/aral.git//lz-modules/network-loadbalancer"

  ### Network Load Balancer Module
  naming      = "printer-dx-usa"
  subnets     = ["subnet-05d725f51d4f7b967", "subnet-0726407eb965a43af"]
  environment = "pro"
  vpc_id      = "vpc-037ee407ccab16603" # For security group association

  tags = {
    Project = "NetworkLoadBalancerModule"
  }
  # Configuración de listeners para el NLB
  lb_listeners = {
    dx-515-usa = { // listener-dx-tcp-515-usa
      vpc_id   = "vpc-037ee407ccab16603"
      port     = 515
      protocol = "TCP"
      target_group = [
        {
          target_ip = "10.57.16.13"
          port      = 515
        }
      ]
    }
  }
}
## NLB for VPN connections in USA
module "network_load_balancer_vpn_usa" {
  source = "git::https://github.com/LorenzoDTT/aral.git//lz-modules/network-loadbalancer"

  ### Network Load Balancer Module
  naming      = "printer-vpn-usa"
  subnets     = ["subnet-05d725f51d4f7b967", "subnet-0726407eb965a43af"]
  environment = "pro"
  vpc_id      = "vpc-037ee407ccab16603"

  tags = {
    Project = "NetworkLoadBalancerModule"
  }
  # Configuración de listeners para el NLB
  lb_listeners = {
    vpn-515-usa = { // listener-vpn-tcp-515-usa
      vpc_id   = "vpc-037ee407ccab16603"
      port     = 515
      protocol = "TCP"
      target_group = [
        {
          target_ip = "10.57.16.141" # ATT
          port      = 515
        },
        {
          target_ip = "10.57.16.205" # Spectrum
          port      = 515
        }
      ]
    }
  }
}