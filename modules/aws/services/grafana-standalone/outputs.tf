#Ec2 vm ip
output "aws_vm_grafana_pub_endpoint" {
  value = "Hey! Go and check deployed Grafana on AWS by link: http://${aws_instance.ec2.public_ip}:3000"
}

output "aws_vm_connect_via_ssh" {
  value = "Access via ssh using command: ssh -i <deploy-key-path> ubuntu@${aws_instance.ec2.public_ip}"
}