data "aws_caller_identity" "peer" {
  provider = aws.accepter
}

data "aws_availability_zones" "available" {
  state = "available"
}
