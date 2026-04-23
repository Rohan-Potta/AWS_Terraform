terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.5.0, <= 1.14.8"
}


# Configure the AWS Provider
provider "aws" {
  region = var.primary_region
  alias  = "primary"
}

provider "aws" {
  region = var.secondary_region
  alias  = "secondary"
}