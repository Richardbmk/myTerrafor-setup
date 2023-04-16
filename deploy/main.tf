terraform {
  backend "s3" {
    bucket         = "rick76599-terraform-setup-tfstate"
    key            = "terraform-setup.tfstate"
    encrypt        = true
    region         = "us-east-2"
    dynamodb_table = "terraform-setup-tf-state-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.1.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

