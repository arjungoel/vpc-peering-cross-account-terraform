# vpc-peering-cross-account-terraform

**Resources to be created**:
1. VPC in Owner Account
2. VPC in Accepter Account
3. 2 Public & Private Subnet(s)
4. IGW
5. NAT GW
6. Public RT & Private RT
7. Public & Private Route(s)
8. VPC Peering Connections for Owner & Accepter


In this code, I am **not** assuming an `IAM role` and **using** `IAM user`. So try to replace it with the **Access Keys (Access Key ID + Secret access Key)** for your two AWS accounts.
