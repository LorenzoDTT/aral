
data "aws_caller_identity" "context" {}
data "aws_region" "context" {}

data "aws_vpc" "workload" {
  id = aws_vpc.workload.id
}

# IPAM Pool

data "aws_ssm_parameter" "ipam_pool_id" {
  provider = aws.sharedservices
  name     = "/ipam/pool/${local.ipam_pool[var.environment]}"
}

data "aws_ssm_parameter" "tgw_id" {
  provider = aws.sharedservices
  name     = "/tgw/id/spain"
}
