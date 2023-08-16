variable "ec2-name" {
  type        = list
  description = "variable for ec2 instance name"
}

variable "ec2-type" {
  type        = list
  description = "variable for ec2 instance type"
}



variable "ec2-env" {
  type        = string
  description = "variable for ec2 environment"
}

variable "ec2-subnet" {
  type        = string
  description = "variable for ec2 subnet"
}

variable "ec2-ami" {
  type        = string
  description = "variable for ec2 subnet"
}

# variable "ec2-sg" {
#   type        = string
#   description = "variable for ec2 subnet"
# }