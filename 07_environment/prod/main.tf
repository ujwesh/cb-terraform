provider "aws" {

}


# module "s3" {
#   source      = "../../06_modules/S3"
#   bucket_name = ["ujwesh-44", "atul-44", "pritam-44", "suraj-44"]
#   env         = "prod"
# }



# module "ec2-instance" {
#   source   = "../../06_modules/EC-2"
#   ec2-name = ["instance-1", "instance-2", "instance-3", "instance-4", "instance-5", "try-instance"]
#   ec2-type = ["t2.micro", "t2.medium", "t2.small", "t3.micro", "t3.medium", "t3.small"]
#   ec2-env = "prod"
# }



# module "iam-users" {
#   source   = "../../06_modules/IAM-user"
#   iam-name = ["ujwesh", "vijay", "atul", "prem"]
#   iam-env  = "prod"
# }


module "vpc" {
  source             = "../../06_modules/vpc"
  cidr-block         = "10.0.0.0/16"
  vpc-name           = "my-vpc"
  public-cidr-block  = "10.0.48.0/20"
  private-cidr-block = ["10.0.16.0/20", "10.0.32.0/20"]
  public-subnet      = "vpc-public-subnet"
  private-subnet     = "vpc-private-subnet"
  public-RT          = "vpc-public-RT"
  private-RT         = "vpc-private-RT"
  IGW-main           = "vpc-IGW-main"
  NAT-gw             = "vpc-NAT-gw"
  vpc-env            = "prod"
}