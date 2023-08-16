provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "EC2" {
  ami           = var.ec2-ami
  instance_type = var.ec2-type[count.index]
  count         = length(var.ec2-name)
  subnet_id     = var.ec2-subnet
  # security_groups = [var.ec2-sg]
  tags = {
    Name = "${var.ec2-name[count.index]}-${var.ec2-env}"
  }
}