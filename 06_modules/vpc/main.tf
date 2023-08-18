## create vpc:-

resource "aws_vpc" "main" {
  cidr_block           = var.cidr-block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true

  tags = merge(var.tags, tomap({
    Name = format("%s-%s", var.vpc-name, var.vpc-env), "environment" = var.vpc-env
    
    # Name = "${var.vpc-name}-${var.vpc-env}"
  }))
}


## create 1 public & 2 private subnets:-

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public-cidr-block
  availability_zone = var.availability-zone[5]

  # cidr_block = "${var.Private_Subnet_1}"   differnce in line 19 & 20

  tags = merge(var.tags, tomap({
    Name = format("%s-%s-%s", var.public-subnet, var.vpc-env, var.availability-zone[5]), "type" = "public"
    
    # Name = "${var.public-subnet}-${var.vpc-env}"
  }))
}

resource "aws_subnet" "private" {
  count             = length(var.private-cidr-block)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private-cidr-block[count.index]
  availability_zone = element(var.availability-zone, count.index)


  tags = merge(var.tags, tomap({
    Name = format("%s-%s-%s", var.private-subnet, var.vpc-env, element(var.availability-zone, count.index)), "type" = "private"
    
    # Name = "${var.private-subnet}-${var.vpc-env}"
  }))
}


## create public & private RT:-

resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.main.id

  tags =  merge(var.tags, {
    Name = format("%s-%s", var.public-RT, var.vpc-env)
    
    # Name = "${var.public-RT}-${var.vpc-env}"
  })
}

resource "aws_route_table" "private-RT" {
  vpc_id = aws_vpc.main.id

  tags =  merge(var.tags, {
    Name = format("%s-%s", var.private-RT, var.vpc-env)

    # Name = "${var.private-RT}-${var.vpc-env}"
  })
}


## associate subnet to RT (associate specific IPs to resp. route tables):-

resource "aws_route_table_association" "public-RTA" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-RT.id
}

resource "aws_route_table_association" "private-RTA" {
  count          = length(var.private-cidr-block)
  subnet_id      = aws_subnet.private[count.index].id #ask why
  route_table_id = aws_route_table.private-RT.id
}


## create igw & NAT-gateway+elastic-IP for Routing:-

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge( var.tags, {
    Name = format("%s-%s", var.IGW-main, var.vpc-env)

    # Name = "${var.IGW-main}-${var.vpc-env}"
  })
}

# elastic ip for NAT-gw:-

resource "aws_eip" "elastic-ip" {
  # vpc = true
  depends_on = [aws_internet_gateway.igw]
}

# NAT-gateway (NAT is given ublic subnet so that it can have internet access & provide it to private instance)

resource "aws_nat_gateway" "NAT-gw" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public.id

  tags =  merge(var.tags, {
    Name = format("%s-%s", var.NAT-gw, var.vpc-env)
    
    # Name = "${var.NAT-gw}-${var.vpc-env}"
  })

  depends_on = [aws_internet_gateway.igw]
}


## Routing for public & private RT (from where traffic should flow):-

resource "aws_route" "Public-route" {
  route_table_id         = aws_route_table.public-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [aws_route_table.public-RT]
}

resource "aws_route" "Private-route" {
  route_table_id         = aws_route_table.private-RT.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NAT-gw.id

  depends_on = [aws_route_table.private-RT]
}

###
# resource "aws_security_group" "Sg" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = [aws_vpc.main.cidr_block]
#     # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   # tags = {
#   #   Name = "allow_tls"
#   # }
# }