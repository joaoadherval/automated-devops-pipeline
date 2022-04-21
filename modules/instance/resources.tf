# Setting up provider
provider "aws"{
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Creating a network interface w/ an IP on the subnet
resource "aws_network_interface" "devops_nic" {
  subnet_id       = var.devops_subnet
  private_ips     = ["10.0.1.50"]
  security_groups = var.devops_security_group
}

# Assiging elastic (public) ip address to the network interface
resource "aws_eip" "jenkins_eip" {
  vpc                       = true
  network_interface         = aws_network_interface.devops_nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [
    var.devops_gw
  ]
}

# Creating EC2 server for jenkins
resource "aws_instance" "jenkins_server" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  availability_zone = var.availability_zone
  key_name        = var.key_name

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.devops_nic.id
  }

  tags = {
    Name = "Jenkins Server"
  }
}