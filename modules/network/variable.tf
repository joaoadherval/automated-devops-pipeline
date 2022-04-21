variable "access_key" {
  description = "Access Key for provisioning on AWS"
  default = ""
}

variable "secret_key" {
  description = "Secret Key for provisioning on AWS"
  default = ""
}

variable "region" {
  description = "Region to be used on on provisioning"
  default = "us-east-1"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "DevOps Pipeline"
}