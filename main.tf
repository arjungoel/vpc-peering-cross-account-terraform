terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.owner_account_id}:role/${var.role_name}"
  }
}

provider "aws" {
  region = var.region
  alias  = "owner"
  assume_role {
    role_arn = "arn:aws:iam::${var.owner_account_id}:role/${var.role_name}"
  }
}

provider "aws" {
  region  = var.region
  alias   = "accepter"
  profile = var.profile_accepter
  assume_role {
    role_arn = "arn:aws:iam::${var.accepter_account_id}:role/${var.role_name}"
  }
}

module "vpc-peering-module" {
  source               = "./vpc-peering-module"
  region               = var.region
  cidr_block           = var.cidr_block
  cidr_block2          = var.cidr_block2
  default_tags         = var.default_tags
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  owner_account_id     = var.owner_account_id
  accepter_account_id  = var.accepter_account_id
  role_name            = var.role_name
  profile_accepter     = var.profile_accepter
}
