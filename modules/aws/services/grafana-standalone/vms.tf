#Creating SSH key resource for remote connections
resource "aws_key_pair" "wks4-deploy" {
  key_name   = "wks4-deploy"
  public_key = file("${var.ssh_key_path}")
}


resource "aws_instance" "ec2" {
  ami           = var.vm-ami
  instance_type = var.vm_instance_type

  subnet_id                   = aws_subnet.pub_sub.id
  vpc_security_group_ids      = [aws_security_group.vm-sg.id]
  associate_public_ip_address = true
  key_name  = aws_key_pair.wks4-deploy.key_name
  user_data ="${file("${path.module}/metadata/grafana-spray.sh")}"

  tags = {
    Name = "ec2-vm"
  }
}


