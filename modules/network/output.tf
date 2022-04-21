output "vpc_id" {
  value = "${aws_vpc.devops_vpc.id}"
}
output "public_subnets" {
  value = ["${aws_subnet.devops_subnet.id}"]
}