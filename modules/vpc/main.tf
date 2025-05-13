resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.region_name}_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.region_name}_igw"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
  tags = {
    Name = "${var.region_name}_eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id = values(aws_subnet.public_subnet)[0].id
  depends_on = [ aws_internet_gateway.igw ]
  tags = {
    Name = "${var.region_name}_nat"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each = toset(var.public_subnet_cidr)
  vpc_id = aws_vpc.vpc.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.region_name}_public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each = toset(var.private_subnet_cidr)
  cidr_block = each.value
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.region_name}_private_subnet"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route  {
    cidr_block = var.cidr_allowing_all
    gateway_id = aws_internet_gateway.igw.id
    
  }
  tags = {
    Name = "${var.region_name}_public_routetable"
  }
}

resource "aws_route_table_association" "public_route_table_assosciations" {
  for_each = aws_subnet.public_subnet
  subnet_id = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.cidr_allowing_all
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.region_name}private_routetable"
  }
}

resource "aws_route_table_association" "private_route_table_assosciations" {
  for_each = aws_subnet.private_subnet
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}