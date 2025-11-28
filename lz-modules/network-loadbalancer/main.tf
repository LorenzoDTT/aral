#######################################################
## Network Load Balancer Module
#######################################################
resource "aws_lb" "nlb" {
  name               = "nlb-${var.naming}-${var.environment}"
  internal           = true
  load_balancer_type = "network"
  security_groups    = [aws_security_group.nlb_sg.id]
  subnets            = var.subnets

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = merge(
    var.tags,
    {
      Name = "nlb-${var.naming}-${var.environment}"
    }
  )
}

resource "aws_lb_listener" "nlb_listener" {
  for_each          = var.lb_listeners
  load_balancer_arn = aws_lb.nlb.arn
  port              = each.value.port
  protocol          = each.value.protocol

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.ips[each.key].arn
        weight = each.value.weight != null ? each.value.weight : 100
      }
    }
  }
  tags = merge(
    var.tags,
    {
      Name = "nlb-${each.key}-${var.environment}"
    }
  )
}

resource "aws_lb_target_group" "ips" {
  for_each    = { for k, v in var.lb_listeners : k => v }
  name        = "nlb-tg-${each.key}-${var.environment}"
  port        = each.value.port
  protocol    = each.value.protocol
  vpc_id      = each.value.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 2
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 2
    protocol            = "TCP"
  }

  tags = merge(
    var.tags,
    {
      Name = "nlb-tg-${each.key}-${var.environment}"
    }
  )

}
locals {
  target_ips = flatten([
    for listener_key, listener in var.lb_listeners : [
      for ip in listener.target_group : {
        listener_key = listener_key
        target_ip    = ip.target_ip
        port         = ip.port
      }
    ]
  ])
}

resource "aws_lb_target_group_attachment" "targets_ips" {
  depends_on       = [aws_lb_target_group.ips]
  for_each         = tomap({ for ip in local.target_ips : "${ip.listener_key}-${ip.target_ip}" => ip })
  target_group_arn = aws_lb_target_group.ips[each.value.listener_key].arn
  availability_zone = "all"
  target_id        = each.value.target_ip
  port             = each.value.port

}

################### Temporal Security Group para NLB #######################
resource "aws_security_group" "nlb_sg" {
  name        = "nlb-sg-${var.naming}-${var.environment}"
  description = "Security group for NLB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 515
    to_port     = 515
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    var.tags,
    {
      Name = "nlb-sg-${var.naming}-${var.environment}"
    }
  )
}