# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "dev" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = local.common_tags
}

# Creating Public Subnets in VPC
resource "aws_subnet" "dev-public-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.subnet1
  map_public_ip_on_launch = "true"
  availability_zone       = var.avzone1

  tags = local.common_tags
}

# Creating Private Subnets in VPC
resource "aws_subnet" "dev-private-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.subnet2
  map_public_ip_on_launch = "false"
  availability_zone       = var.avzone1

  tags = local.common_tags
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev.id

  tags = local.common_tags
}

# Creating Route Tables for Internet gateway
resource "aws_route_table" "dev-public" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  tags = local.common_tags
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

  tags = local.common_tags
}

# Creating route associations for private Subnets
resource "aws_route_table_association" "dev-private-1-a" {
  subnet_id      = aws_subnet.dev-private-1.id
  route_table_id = aws_route_table.dev-private.id
}


# Create a Security Group
resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.dev.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = local.common_tags
}
# Create an EC2 instance
resource "aws_instance" "my_ec2" {
  ami             = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (adjust based on your region)
  instance_type   = var.inst
  subnet_id       = aws_subnet.dev-public-1.id
  security_groups = [aws_security_group.my_sg.name]  # Attach security group

  tags = local.common_tags

  # Optional: Add a key pair for SSH access
  key_name = "mykeypair"  # Ensure you have a key pair created in AWS or remove this line if not needed
}

output "instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
}