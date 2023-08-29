# Define AWS Region
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

#Define IAM User Access Key
variable "access_key" {
  description = "The access_key that belongs to the IAM user in Owner Account"
  type        = string
  sensitive   = true
}

#Define IAM User Secret Key
variable "secret_key" {
  description = "The secret_key that belongs to the IAM user in Owner Account"
  type        = string
  sensitive   = true
}

variable "access_key2" {
  description = "The access_key that belongs to the IAM user in Accepter Account"
  type        = string
  sensitive   = true
}

variable "secret_key2" {
  description = "The secret_key that belongs to the IAM user in Accepter Account"
  type        = string
  sensitive   = true
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
