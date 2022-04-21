output "vpc_id" {
  value = "${aws_vpc.devops_vpc.id}"
}

output "devops_subnet" {
  value = ["${aws_subnet.devops_subnet.id}"]
}

output "devops_gw" {
  value = ["${aws_internet_gateway.devops_gw.id}"]
}