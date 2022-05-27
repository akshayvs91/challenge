terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.10"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
