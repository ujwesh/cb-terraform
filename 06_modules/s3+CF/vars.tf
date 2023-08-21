variable "bucket-name" {
  type = string
}

variable "acl-access" {
  type = string
}

variable "bucket-versioning" {
  type = bool
}

variable "block-public-acls" {
  type = bool
}

variable "block-public-policy" {
  type = bool
}

variable "ignore-public-acls" {
  type = bool
}

variable "restrict-public-buckets" {
  type = bool
}





variable "env" {
  type = string
}