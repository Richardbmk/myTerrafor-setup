provider "aws" {
  region  = "us-east-2"
  version = "~> 2.50.0"
}

terraform {
  backend "s3" {
    bucket         = "rick-terraform-setup-tfstate"
    key            = "terraform-setup.tfstate"
    encrypt        = true
    region         = "us-east-2"
    dynamodb_table = "terraform-setup-tf-state-lock"
  }
}

