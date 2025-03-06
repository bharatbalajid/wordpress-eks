provider "aws" {
  region = var.aws_region
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }
  }
  backend "s3" {
    bucket  = "bharat-terraform-backend-nv"
    key     = "aws/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}