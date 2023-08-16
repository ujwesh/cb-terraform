######################################################################
# STRING

# variable "env" {
#   type    = string
#   default = "dev"
# }

variable "env" {                      # these need to be mentioned while using .tfvars file

}

# variable "number" {                   # these need to be mentioned while using .tfvars file

# }



resource "aws_s3_bucket" "s3-bucket" {
  bucket = "ujwesh-${var.env}"

  tags = {
    env = var.env
  }
}


######################################################################
# NUMBER

# variable "ref-name" {
#     type = number
#     default = 10
# }



######################################################################
# BOOLEAN   (true/false)

# variable "value" {
#     type = bool
#     default = false
# }



######################################################################
# list

# variable "names" {
#   type = list
#   default = ["ujwesh", "atul", "pritam", "vice"]
# }


# resource "aws_s3_bucket" "s3-bucket" {
#   bucket = "ujwesh-${var.names[1]}"

#   tags = {
#     env = var.names[1]
#   }
# }




######################################################################
# map

# variable "map-me" {
#   type = map
#   default = {
#     "name"   = "ujwesh"
#     "place"  = "nagpur"
#     "animal" = "lion"
#     "env"  = "test"
#   }
# }


# resource "aws_s3_bucket" "s3-bucket" {
#   bucket = "ujwesh-${var.map-me.animal}"

#   tags = {
#     env = var.map-me.place
#   }
# }




######################################################################
# any

# variable "try" {
#   type    = any
#   default = "pro"

# }


# resource "aws_s3_bucket" "s3-bucket" {
#   bucket = "ujwesh-${var.try}"

#   tags = {
#     env = var.try
#   }
# }



######################################################################
# map(string)               #can also use true/false in this for bool directly

# variable "combo" {
#   type = map(string)
#   default = {
#     bucket = "ujwesh95"
#     env    = "pre-prod"
#   }

# }


# resource "aws_s3_bucket" "s3-bucket" {
#   bucket = "ujwesh-${var.combo["bucket"]}"

#   tags = {
#     env = var.combo["env"]
#   }
# }



######################################################################
# list(string)              #can also use true/false in this for bool directly


# variable "combo" {
#   type    = list(string)
#   default = ["test95", "UAT", "false"]
# }

# resource "aws_s3_bucket" "s3-bucket" {
#   bucket = "ujwesh-${var.combo[0]}"

#   tags = {
#     env = var.combo[1]
#   }
# }