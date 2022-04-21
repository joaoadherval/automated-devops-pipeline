# Setting up provider
provider "aws"{
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Setting up vpc 
resource "aws_vpc" "devops_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.environment_tag
  }
}

# Setting up internet gateway
resource "aws_internet_gateway" "devops_gw" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = var.environment_tag
  }
}

# Setting up custom route table
resource "aws_route_table" "devops_route_table" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.devops_gw.id
  }

  tags = {
    Name = var.environment_tag
  }
}

# Setting up subnet
resource "aws_subnet" "devops_subnet" {
  vpc_id     = aws_vpc.devops_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = var.environment_tag
  }
}

# Associating the subnet w/ route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.devops_subnet.id
  route_table_id = aws_route_table.devops_route_table.id
}