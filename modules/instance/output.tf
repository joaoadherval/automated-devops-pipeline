output "instance_eip" {
  value = "${aws_eip.jenkins_server.public_ip}"
}