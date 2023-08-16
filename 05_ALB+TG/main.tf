provider "aws" {
  region = "us-east-1"  # Replace this with your desired AWS region
}

resource "aws_lb" "uk_alb" {
  name               = "MyApplicationLoadBalancer"
  subnets            = ["subnet-0f8e423a38a9f4e2c", "subnet-011761f7b29cfbe6b", "subnet-03bd120b30703b4d0", "subnet-0bf2d164f81f0c641", "subnet-0964ae0ea36af0d5d"]  # Replace with your subnet IDs
  security_groups    = ["sg-034efb2cd888876b8"]  # Replace with your security group ID
  load_balancer_type = "application"
}

resource "aws_lb_target_group" "uk_target_group" {
  count     = 5
  name      = "MyTargetGroup-${count.index + 1}"
  port      = 80 + count.index
  protocol  = "HTTP"
  vpc_id    = "vpc-06e7b097bcb3b0239"  # Replace with your VPC ID
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.uk_alb.arn
  port              = 80 + count.index
  protocol          = "HTTP"
  count             = 5
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.uk_target_group[count.index].arn
  }
}
