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
  assume_role {
    role_arn = "arn:aws:iam::${var.owner_account_id}:role/${var.role_name}"
  }
}

provider "aws" {
  region     = var.region
  alias      = "owner"
  assume_role {
    role_arn = "arn:aws:iam::${var.owner_account_id}:role/${var.role_name}"
  }
}

provider "aws" {
  region     = var.region
  alias      = "accepter"
  profile = var.profile_accepter
  assume_role {
    role_arn = "arn:aws:iam::${var.accepter_account_id}:role/${var.role_name}"
  }
}