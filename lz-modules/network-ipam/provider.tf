terraform {
  required_providers {
    aws = {
      version = ">= 3.70.0"
      source  = "hashicorp/aws"
      configuration_aliases = [ aws.eu_south_2, aws.us_east_1]
    }
  }
}