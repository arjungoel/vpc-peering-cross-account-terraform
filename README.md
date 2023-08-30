# vpc-peering-cross-account-terraform

**Resources to be created**:
1. VPC in Owner Account
2. VPC in Accepter Account

**Owner Account VPC**: <br>
3. 2 Public & Private Subnet(s)
4. IGW
5. NAT GW
6. Public RT & Private RT
7. Public & Private Route(s)

**Accepter Account VPC**:
8. Default Main RT

9. VPC Peering Connections for Owner & Accepter


In this code, I am **not** assuming an `IAM role` and **using** `IAM user`. So try to replace it with the **Access Keys (Access Key ID + Secret access Key)** for your two AWS accounts.

**Important links to follow for the same**:

- https://skundunotes.com/2021/08/24/vpc-peering-using-terraform-across-separate-aws-accounts/
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options.html
