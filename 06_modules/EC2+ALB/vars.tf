variable "vpc-name" {
  type = string
}


variable "vpc-cidr-block" {
  type = string
}


variable "public-subnet" {
  type = string
}

variable "public-cidr-block" {
  type = list
}

## for Az:
variable "availability-zone" {
  type = list
}




##


variable "public-RT" {
  type = string
}

variable "IGW" {
  type = string
}


##
variable "vpc-env" {
  type = string
}



# ## root modules tags:
# variable "tags" {
#   type        = map
#   default     = {}
# }


## EC2

variable "ec2-name" {
  type = string
}

variable "ami" {
  type = string
}

variable "associate-publicIP" {
  type = bool
}


## SG

variable "sg-name" {
  type = string
}

## ALB
variable "enable-deletion-protection" {
  type        = string
}

variable "Alb-name" {
  type        = string
}

variable "internal" {
  type        = string
}

variable "Lb-type" {
  type        = string
}


# TG & Listner:
variable "tg-name" {
  type        = string
}

variable "tg-port" {
  type        = string
}

variable "listner-port" {
  type        = string
}

variable "listner-action-type" {
  type        = string
}

  
