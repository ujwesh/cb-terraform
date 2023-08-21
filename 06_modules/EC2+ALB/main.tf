#provider

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.13.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"

}




# VPC

resource "aws_vpc" "main" {
  cidr_block = var.vpc-cidr-block 

  tags = {
    Name = format("%s-%s", var.vpc-name, var.vpc-env) 
  }
}


# subnets

resource "aws_subnet" "public-subnet" {
  count = length(var.public-cidr-block)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public-cidr-block[count.index] 
  availability_zone = element(var.availability-zone, count.index)

  tags = {
    Name = format("%s-%s", var.public-subnet, var.vpc-env)  
  }
}


# route table

resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s", var.public-RT, var.vpc-env)
    
  }
}


# route table association + routes 1

resource "aws_route_table_association" "RT-associate-1" {
  count          = length(var.public-cidr-block)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-RT.id
}

resource "aws_route" "Route1" {
  route_table_id            = aws_route_table.public-RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id

  depends_on                = [aws_route_table.public-RT]
}


# IGW

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s", var.IGW, var.vpc-env)
  }
}


# EC2 resource

resource "aws_instance" "first" {
  count          = length(var.public-cidr-block)
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet[count.index].id
  associate_public_ip_address = var.associate-publicIP
  security_groups  =  [aws_security_group.sg.id]

  tags = {
    Name = format("%s-%s-%s", var.ec2-name, count.index + 1, var.vpc-env)
  }
}



# SG

resource "aws_security_group" "sg" {
  name        = "ALB-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = format("%s-%s", var.sg-name, var.vpc-env)
  }
}


# ALB:-

resource "aws_lb" "ALB-test" {
  name               = var.Alb-name
  internal           = var.internal
  load_balancer_type = var.Lb-type
  security_groups    = [aws_security_group.sg.id]
  subnets            = [
    aws_subnet.public-subnet[0].id,
    aws_subnet.public-subnet[1].id
  ]

  enable_deletion_protection = var.enable-deletion-protection


  tags = {
    Environment = format("%s-%s", var.Alb-name, var.vpc-env)
  }
}


# ALB-TG:-

resource "aws_lb_target_group" "ALB-tg" {
  name     = var.tg-name
  port     = var.tg-port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}


# TG-attach
resource "aws_lb_target_group_attachment" "tg-attach" {
  count       = length(aws_instance.first)
  target_group_arn = aws_lb_target_group.ALB-tg.arn
  target_id        = aws_instance.first[count.index].id
  port             = 80
}


# listner:-    

resource "aws_lb_listener" "ALB-listner" {
  load_balancer_arn = aws_lb.ALB-test.arn
  port              = var.listner-port
  protocol          = "HTTP"

  default_action {
    type             = var.listner-action-type
    target_group_arn = aws_lb_target_group.ALB-tg.arn
  }
}

