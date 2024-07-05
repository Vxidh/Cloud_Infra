terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "eu-west-2"
}