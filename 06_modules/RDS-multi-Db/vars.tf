variable "allocated-storage" {
  type        = number
}

variable "storage-type" {
  type        = string
}

variable "engine" {
  type        = list
}

# variable "engine-version" {
#   type        = string
# }

variable "instance-class" {
  type        = string
}

variable "identifier" {
  type        = list
}

variable "username" {
  type        = string
}

variable "password" {
  type        = string
}

variable "skip-final-snapshot" {
  type        = bool
}

variable "publicly-accessible" {
  type        = bool
}

variable "availability-zone" {
  type        = string
}


variable "env" {
  type        = string
}