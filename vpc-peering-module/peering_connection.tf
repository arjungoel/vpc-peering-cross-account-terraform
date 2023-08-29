# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  provider = aws.owner

  vpc_id        = aws_vpc.owner.id
  peer_vpc_id   = aws_vpc.accepter.id
  peer_owner_id = data.aws_caller_identity.peer.account_id
  auto_accept   = false

  tags = {
    Side = "Owner"
    Name = "${var.default_tags.project_name}-owner-to-peer"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider = aws.accepter

  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
    Name = "${var.default_tags.project_name}-accepter-to-peer"
  }
}
