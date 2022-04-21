# Setting up provider
provider "aws"{
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Creating a vpc 
resource "aws_vpc" "devops-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "DevOps VPC"
  }
}

# Creating an internet gateway
resource "aws_internet_gateway" "devops_gw" {
  vpc_id = aws_vpc.devops-vpc.id

  tags = {
    Name = "DevOps Gateway"
  }
}

# creating a custom route table
resource "aws_route_table" "devops-route-table" {
  vpc_id = aws_vpc.devops-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.devops_gw.id
  }

  tags = {
    Name = "DevOps Route Table"
  }
}

# Creating a subnet
resource "aws_subnet" "devops-subnet" {
  vpc_id     = aws_vpc.devops-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "DevOps Subnet"
  }
}

# associating the subnet w/ route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.devops-subnet.id
  route_table_id = aws_route_table.devops-route-table.id
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow Jenkins Traffic"
  vpc_id      = aws_vpc.devops-vpc.id

  ingress {
    description      = "Allow from Personal CIDR block"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow SSH from Personal CIDR block"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Jenkins SG"
  }
}

# Creating a network interface w/ an IP on the subnet
resource "aws_network_interface" "devops-nic" {
  subnet_id       = aws_subnet.devops-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.jenkins_sg.id]
}

# Assing elastic (public) ip address to the network interface
resource "aws_eip" "jenkins_eip" {
  vpc                       = true
  network_interface         = aws_network_interface.devops-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [
    aws_internet_gateway.devops_gw
  ]
}

resource "aws_instance" "jenkins_server" {
  ami             = "ami-04505e74c0741db8d"
  instance_type   = "t2.micro"
  availability_zone = "us-east-1a"
  key_name        = var.key_name

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.devops-nic.id
  }

  tags = {
    Name = "Jenkins Server"
  }
}