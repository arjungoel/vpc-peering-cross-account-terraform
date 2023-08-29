terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  alias      = "owner"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key2
  secret_key = var.secret_key2
  alias      = "accepter"
}

module "vpc-peering-module" {
  source                        = "./vpc-peering-module"
  region                        = var.region
  access_key                    = var.access_key
  secret_key                    = var.secret_key
  access_key2                   = var.access_key2
  secret_key2                   = var.secret_key2
  cidr_block                    = var.cidr_block
  cidr_block2                   = var.cidr_block2
  default_tags                  = var.default_tags
  public_subnet_count           = var.public_subnet_count
  private_subnet_count          = var.private_subnet_count
}
