# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "dev" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "dev"
  }
}

# Creating Public Subnets in VPC
resource "aws_subnet" "dev-public-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.subnet1
  map_public_ip_on_launch = "true"
  availability_zone       = var.avzone1

  tags = {
    Name = "dev-public-1"
  }
}

# Creating Private Subnets in VPC
resource "aws_subnet" "dev-private-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.subnet2
  map_public_ip_on_launch = "false"
  availability_zone       = var.avzone1

  tags = {
    Name = "dev-private-1"
  }
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "dev"
  }
}

# Creating Route Tables for Internet gateway
resource "aws_route_table" "dev-public" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  tags = {
    Name = "dev-public-1"
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "dev-public-1-a" {
  subnet_id      = aws_subnet.dev-public-1.id
  route_table_id = aws_route_table.dev-public.id
}
# Creating Nat Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.dev-private-1.id
  depends_on    = [aws_internet_gateway.dev-gw]
}

# Add routes for VPC
resource "aws_route_table" "dev-private" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "dev-private-1"
  }
}

# Creating route associations for private Subnets
resource "aws_route_table_association" "dev-private-1-a" {
  subnet_id      = aws_subnet.dev-private-1.id
  route_table_id = aws_route_table.dev-private.id
}
