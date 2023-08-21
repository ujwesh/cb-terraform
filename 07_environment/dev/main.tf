provider "aws" {

}


###### s3

# module "s3" {
#   source      = "../../06_modules/S3"
#   bucket_name = ["ujwesh-44", "atul-44", "pritam-44", "suraj-44"]
#   env         = "dev"
# }



###### EC2

# module "ec2-instance" {
#   source = "../../06_modules/EC-2"
#   ec2-name = ["instance-1", "instance-2", "instance-3", "instance-4", "instance-5", "try-instance"]
#   ec2-type = ["t2.micro", "t2.medium", "t2.small", "t3.micro", "t3.medium", "t3.small"]
#   ec2-ami  = "ami-08a52ddb321b32a8c"
#   # ec2-subnet = module.vpc.public_subnet_ids
#   ec2-env    = "dev"
# }

# ec2-name = ["instance-1"]
# ec2-type = ["t2.micro"]
#   ec2-ami  = "ami-08a52ddb321b32a8c"
#   ec2-sg   = "sg-0808f0b14acc5f505"
#   ec2-subnet = module.vpc.public_subnet_ids


# module "iam-users" {
#   source   = "../../06_modules/IAM-user"
#   iam-name = ["ujwesh", "vijay", "atul", "prem"]
#   iam-env  = "dev"
# }



######  VPC

# module "vpc" {
#   source             = "../../06_modules/vpc"
#   cidr-block         = "10.0.0.0/16"
#   vpc-name           = "my-vpc"
#   public-cidr-block  = "10.0.1.0/24"
#   private-cidr-block = ["10.0.2.0/24", "10.0.3.0/24"]
#   public-subnet      = "vpc-public-subnet"
#   private-subnet     = "vpc-private-subnet"
#   public-RT          = "vpc-public-RT"
#   private-RT         = "vpc-private-RT"
#   IGW-main           = "vpc-IGW-main"
#   NAT-gw             = "vpc-NAT-gw"
#   vpc-env            = "dev"
#   availability-zone  = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f",]

#   tags = {
#     data-center = "mumbai"
#     owner     = "bata"
#     cost-center    = "bata-cost-0012"
#     mail-id   = "bata123@gmail.com"
#   }

# }

# output "PublicSub" {
#   value = module.vpc.public_subnet_ids
# }

# output "PrivateSub" {
#   value = module.vpc.private_subnet_ids
# }




########## VPC + EC2

# module "VPC-EC2" {
#   source            = "../../06_modules/EC2+ALB"
#   vpc-name          = "ALB-vpc"
#   vpc-cidr-block    = "10.0.0.0/16"
#   public-subnet     = "public-subnet1"
#   availability-zone = ["us-east-1a", "us-east-1b", "us-east-1c"]
#   public-cidr-block = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public-RT         = "public-RT"
#   IGW               = "my-igw"
#   vpc-env           = "dev"

#   ec2-name = "instance"
#   ami      = "ami-08a52ddb321b32a8c"
#   associate-publicIP = true

#   sg-name  = "ALB-security-group"

#   enable-deletion-protection = false
#   Alb-name                   = "My-LB"
#   internal                   = false
#   Lb-type                    = "application"

#   tg-name                    = "Alb-target-group"
#   tg-port                    = "80"

#   listner-port               = "80"
#   listner-action-type        = "forward"
# }



########## s3 + cf:-

# module "S3-CF" {
#   source      = "../../06_modules/s3+CF"
#   bucket-name = "cf-hosting-9090"
#   acl-access  = "private"

#   bucket-versioning = false

#   block-public-acls       = false
#   block-public-policy     = false
#   ignore-public-acls      = false
#   restrict-public-buckets = false


#   env = "dev"
# }



########## rds multple data base:-

module "RDS-multiDb" {
  source      = "../../06_modules/RDS-multi-Db"
  allocated-storage    = 20
  storage-type         = "gp2"
  engine               = ["mysql", "mariadb"]
  # engine-version       = "5.7"
  instance-class       = "db.t2.micro"
  identifier           = ["mysql-rds", "mariadb-rds"]
  username             = "admin"
  password             = "ujwesh28"
  skip-final-snapshot  = true
  publicly-accessible  = false
  availability-zone    = "us-east-1a"


  env = "dev"
}

