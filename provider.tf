terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  shared_credentials_file = "/tmp/credentials"
  profile                 = "default"
  region                  = var.region
}
