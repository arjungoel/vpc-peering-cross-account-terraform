# Requester's side of the connection.
resource "aws_vpc_peering_connection" "owner" {
  provider = aws.owner
  vpc_id        = aws_vpc.owner.id
  peer_vpc_id   = aws_vpc.accepter.id
  peer_owner_id = data.aws_caller_identity.peer.account_id
  auto_accept   = false

  tags = {
    Side = "Owner"
    Name = "${var.default_tags.project_name}-peer-to-accepter"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "accepter" {
  provider = aws.accepter

  vpc_peering_connection_id = aws_vpc_peering_connection.owner.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
    Name = "${var.default_tags.project_name}-peer-to-owner"
  }
}

resource "aws_route" "owner" {
  provider                  = aws.owner
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = aws_vpc.accepter.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.owner.id
}

resource "aws_route" "accepter" {
  provider                  = aws.accepter
  route_table_id            = aws_vpc.accepter.default_route_table_id
  destination_cidr_block    = aws_vpc.owner.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.owner.id
} 
