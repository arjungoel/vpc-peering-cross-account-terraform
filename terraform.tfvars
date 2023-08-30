region      = "us-east-1"
cidr_block  = "10.0.0.0/16"
cidr_block2 = "172.31.0.0/16"
default_tags = {
  primary_owner   = "Arjun Goel"
  secondary_owner = "Arjun Goel"
  project_name    = "vpc-peering-cross-account"
}
public_subnet_count  = 2
private_subnet_count = 2
owner_account_id     = "699972259011"
accepter_account_id  = "436124367077"
profile_accepter     = "dynamodb-user3"
role_name            = "vpc-peering-role"
