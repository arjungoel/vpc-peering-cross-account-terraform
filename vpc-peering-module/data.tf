data "aws_caller_identity" "peer" {
  provider = aws.accepter
}

data "aws_route_tables" "accepter" {
  provider = aws.accepter
  vpc_id   = aws_vpc.accepter.id
}

data "aws_availability_zones" "available" {
  state = "available"
}
