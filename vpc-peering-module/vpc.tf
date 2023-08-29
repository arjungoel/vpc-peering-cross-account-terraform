resource "aws_vpc" "owner" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.default_tags.project_name}-owner-vpc"
  }
  assign_generated_ipv6_cidr_block = true
  instance_tenancy                 = "default"
  enable_dns_hostnames             = true
  enable_dns_support               = true
}

resource "aws_vpc" "accepter" {
  cidr_block = var.cidr_block2
  provider   = aws.accepter
  tags = {
    Name = "${var.default_tags.project_name}-accepter-vpc"
  }
  assign_generated_ipv6_cidr_block = true
  instance_tenancy                 = "default"
  enable_dns_hostnames             = true
  enable_dns_support               = true
}

# Create a Public Subnet for Owner VPC
resource "aws_subnet" "public_subnet" {
  count                           = var.public_subnet_count
  vpc_id                          = aws_vpc.owner.id
  cidr_block                      = cidrsubnet(aws_vpc.owner.cidr_block, 4, count.index)
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.owner.ipv6_cidr_block, 8, count.index)
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true
  tags = {
    Name = "${var.default_tags.project_name}-owner-public-${data.aws_availability_zones.available.names[0]}"
  }
  availability_zone = data.aws_availability_zones.available.names[0]
}

# Create a Public Route table for Owner VPC
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.owner.id
  tags = {
    Name = "${var.default_tags.project_name}-owner-public-route-table"
  }
}

# Create an Internet Gateway to access the route from internet for Owner
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.owner.id
  tags = {
    Name = "${var.default_tags.project_name}-owner-internet-gateway"
  }
}

// Create a Public route for Owner
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

// Associate Route table with Subnet for Owner
resource "aws_route_table_association" "public_rt_subnet_associate" {
  count          = var.public_subnet_count
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

// Create a Private Subnet for Owner
resource "aws_subnet" "private_subnet" {
  count      = var.private_subnet_count
  vpc_id     = aws_vpc.owner.id
  cidr_block = cidrsubnet(aws_vpc.owner.cidr_block, 4, count.index + var.public_subnet_count)
  tags = {
    Name = "${var.default_tags.project_name}-owner-private-${data.aws_availability_zones.available.names[0]}"
  }
  availability_zone = data.aws_availability_zones.available.names[0]
}

# Create a Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.owner.id
  tags = {
    Name = "${var.default_tags.project_name}-owner-private-route-table"
  }
}

# Create an EIP for NAT Gateway
resource "aws_eip" "nat_gateway" {
  vpc = true
  tags = {
    Name = "${var.default_tags.project_name}-owner-nat-eip"
  }
}

# Create a NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnet.0.id

  tags = {
    Name = "${var.default_tags.project_name}-owner-nat-gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.nat_gateway, aws_internet_gateway.igw]
}

// Create a Private route
resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

// Associate Private Route table with Subnet
resource "aws_route_table_association" "private_rt_subnet_associate" {
  count          = var.private_subnet_count
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}
