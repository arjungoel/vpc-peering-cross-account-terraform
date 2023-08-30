# Define AWS Region
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR Block in the owner account"
}

variable "cidr_block2" {
  type        = string
  description = "VPC CIDR Block in the accepter account"
}

variable "default_tags" {
  type        = map(string)
  description = "Tagging used for AWS resource"
}

variable "public_subnet_count" {
  type        = number
  description = "Total number of public subnets to create"
}

variable "private_subnet_count" {
  type        = number
  description = "Total number of private subnets to create"
  default     = 2
}

variable "owner_account_id" {
  type = string
  description = "AWS account id for owner"
}

variable "accepter_account_id" {
  type = string
  description = "AWS account id for accepter"
}

variable "profile_accepter" {
  type = string
  description = "Profile name for accepter account"
}

variable "role_name" {
  type = string
  description = "IAM role name"
}