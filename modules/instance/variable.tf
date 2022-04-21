variable "access_key" {
  description = "Access Key for provisioning on AWS"
  default = ""
}

variable "secret_key" {
  description = "Secret Key for provisioning on AWS"
  default = ""
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_id" {
  description = "VPC id"
  default = ""
}

variable "devops_subnet" {
  description = "VPC subnet id"
  default = ""
}

variable "devops_security_group" {
  description = "EC2 ssh security group"
  # type = list(string)
  default = []
}

variable "key_name" {
  description = "EC2 Key pair name"
  default = ""
}

variable "instance_ami" {
  description = "EC2 instance ami"
  default = "ami-04505e74c0741db8d"
}

variable "availability_zone" {
  description = "Availability Zone of the Instance"
  default = ""
}

variable "devops_gw" {
  default = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}