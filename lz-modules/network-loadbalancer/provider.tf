provider "aws" {
  region = "eu-south-2"
  default_tags {
    tags = {
      environment     = "pro"
      deployment-mode = "terraform"
    }
  }
}
terraform {
  required_providers {
    aws = {
      version = ">= 3.73.0"
      source  = "hashicorp/aws"
    }
  }
}