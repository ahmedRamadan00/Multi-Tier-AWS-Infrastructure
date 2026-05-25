#VPC
resource "aws_vpc" "main" {
  cidr_block           = var.VPC_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

#IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

#public subnets
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a
  availability_zone       = local.az_a
  map_public_ip_on_launch = true

  tags = {
    Name = "Public subnet ${local.az_a}"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b
  availability_zone       = local.az_b
  map_public_ip_on_launch = true

  tags = {
    Name = "Public subnet ${local.az_b}"
  }
}

#private subnets
resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_a
  availability_zone       = local.az_a
  map_public_ip_on_launch = false

  tags = {
    Name = "Private subnet ${local.az_a}"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_b
  availability_zone       = local.az_b
  map_public_ip_on_launch = false

  tags = {
    Name = "Private subnet ${local.az_b}"
  }
}

#DB subnets
resource "aws_subnet" "db_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.db_subnet_a
  availability_zone       = local.az_a
  map_public_ip_on_launch = false

  tags = {
    Name = "DB subnet ${local.az_a}"
  }
}

resource "aws_subnet" "db_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.db_subnet_b
  availability_zone       = local.az_b
  map_public_ip_on_launch = false

  tags = {
    Name = "DB subnet ${local.az_b}"
  }
}

#EIPs
resource "aws_eip" "nat_eip_a" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-a"
  }
}

resource "aws_eip" "nat_eip_b" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-b"
  }
}

#NAT Gateways
resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.public_a.id

  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "nat-gateway-a"
  }
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.public_b.id

  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "nat-gateway-b"
  }
}

#public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

#private route table a
resource "aws_route_table" "private_rt_a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_a.id
  }

  tags = {
    Name = "private-route-table-a"
  }
}

#private route table b
resource "aws_route_table" "private_rt_b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_b.id
  }

  tags = {
    Name = "private-route-table-b"
  }
}

#public route table associations
resource "aws_route_table_association" "public_assoc_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

#private route table associations
resource "aws_route_table_association" "private_assoc_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route_table_association" "private_assoc_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rt_b.id
}

#DB route table associations
resource "aws_route_table_association" "db_assoc_a" {
  subnet_id      = aws_subnet.db_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route_table_association" "db_assoc_b" {
  subnet_id      = aws_subnet.db_b.id
  route_table_id = aws_route_table.private_rt_b.id
}