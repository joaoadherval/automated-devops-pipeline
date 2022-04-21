variable "access_key" {
  description = "Access Key for provisioning on AWS"
}

variable "secret_key" {
  description = "Secret Key for provisioning on AWS"
}

variable "ubuntu_ami_key" {
  description = "Ubuntu AMI value for EC2 instance deploy on AWS Free Tier"
}

variable "cidr_block" {
  description = "CIDR Block to allow Jenkins Access"
}

variable "key_name" {
  description = "Name of keypair to ssh"
}