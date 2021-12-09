# Terraform configurations must declare which providers 
# they require so that Terraform can install and use them.
# Refer to https://www.terraform.io/docs/language/providers/index.html for more details.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "lab"
  region  = var.region
}

resource "random_string" "id_generator" {
  length = 8
  number = true
  special = false
  upper = false
}
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}