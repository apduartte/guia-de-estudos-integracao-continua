resource "aws_vpc" "poc_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "poc-vpc"
  }
}

resource "aws_subnet" "poc_subnet" {
  vpc_id                  = aws_vpc.poc_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "poc-subnet"
  }
}

resource "aws_internet_gateway" "poc_igw" {
  vpc_id = aws_vpc.poc_vpc.id
}

resource "aws_route_table" "poc_rt" {
  vpc_id = aws_vpc.poc_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.poc_igw.id
  }
}

resource "aws_route_table_association" "poc_assoc" {
  subnet_id      = aws_subnet.poc_subnet.id
  route_table_id = aws_route_table.poc_rt.id
}
