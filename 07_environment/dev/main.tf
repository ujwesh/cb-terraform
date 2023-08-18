provider "aws" {

}


# module "s3" {
#   source      = "../../06_modules/S3"
#   bucket_name = ["ujwesh-44", "atul-44", "pritam-44", "suraj-44"]
#   env         = "dev"
# }



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





module "vpc" {
  source             = "../../06_modules/vpc"
  cidr-block         = "10.0.0.0/16"
  vpc-name           = "my-vpc"
  public-cidr-block  = "10.0.1.0/24"
  private-cidr-block = ["10.0.2.0/24", "10.0.3.0/24"]
  public-subnet      = "vpc-public-subnet"
  private-subnet     = "vpc-private-subnet"
  public-RT          = "vpc-public-RT"
  private-RT         = "vpc-private-RT"
  IGW-main           = "vpc-IGW-main"
  NAT-gw             = "vpc-NAT-gw"
  vpc-env            = "dev"
  availability-zone  = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f",]

  tags = {
    data-center = "mumbai"
    owner     = "bata"
    cost-center    = "bata-cost-0012"
    mail-id   = "bata123@gmail.com"
  }

}

# output "PublicSub" {
#   value = module.vpc.public_subnet_ids
# }

# output "PrivateSub" {
#   value = module.vpc.private_subnet_ids
# }
