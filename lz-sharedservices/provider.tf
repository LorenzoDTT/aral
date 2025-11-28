provider "aws" {
  region = "eu-south-2"
  assume_role {
    role_arn = "arn:aws:iam::730335556026:role/lz-deploymentrole"
  }
  default_tags {
    tags = {
      environment     = "pro"
      deployment-mode = "terraform"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
  assume_role {
    role_arn = "arn:aws:iam::730335556026:role/lz-deploymentrole"
  }
  default_tags {
    tags = {
      environment     = "pro"
      deployment-mode = "terraform"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "s3bckt-deployment-lz-tfstates-eus2-001"
    key            = "lz-sharedservices/terraform.tfstate"
    region         = "eu-south-2"
    encrypt        = true
    dynamodb_table = "dyntbl-deployment-lz-tflocks-eus2-001"
  }

  required_providers {
    aws = {
      version = ">= 3.73.0"
      source  = "hashicorp/aws"
    }
  }
}