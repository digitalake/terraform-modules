resource "aws_vpc" "primary_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "pub_sub" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.aws_az
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.primary_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.primary_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "pub-rt-assoc" {
  subnet_id      = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.public_rt.id
}
