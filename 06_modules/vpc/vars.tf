variable "cidr-block" {
  type = string
}

variable "instance_tenancy" {
  type    = string
  default = "dedicated"

}

variable "vpc-name" {
  type = string
}

variable "public-cidr-block" {
  type = string
}


variable "private-cidr-block" {
  type = list(any)
}

##
variable "public-subnet" {
  type = string
}

variable "private-subnet" {
  type = string
}

variable "public-RT" {
  type = string
}

variable "private-RT" {
  type = string
}

variable "IGW-main" {
  type = string
}

variable "NAT-gw" {
  type = string
}

##
variable "vpc-env" {
  type = string
}

## for Az:
variable "availability-zone" {
  type = list
}

## root modules tags:
variable "tags" {
  type        = map
  default     = {}
}
