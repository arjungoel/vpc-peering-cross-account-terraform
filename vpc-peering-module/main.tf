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
