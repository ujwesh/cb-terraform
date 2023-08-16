#### NOTE:- 1. (dev).tfvars       --  have to use this tf plan -var="env=prod"
#           2. (anyname).auto.tfvars  -- it can directly be refered like var.env-name
#           3. alt+ctrl+upper/down arrow -- select lines to add space together.
#           4. alt+shift+down arrow -- copy current line down
#           5. alt+shift+right arrow -- select all content inside brackets



# string
variable "env" {
  type        = string
  default = "dev"       # if not present will ask value
  description = "This is a string." #(optional)
}

resource "aws_s3_bucket" "name" {
  bucket = "ujwesh959697"


  tags = {
    env = var.env
  }
}
# or

resource "aws_s3_bucket" "name" {
  bucket = "ujwesh959697-${var.env}"


  tags = {
    env = var.env
  }
}

# list

variable "bucket_names" {
  type        = list
  default = ["ujwesh", "raj", "atul", "bob"]       # if not present will ask value
  description = "This is a list." #(optional)
}

resource "aws_s3_bucket" "name" {
  bucket = "ujwesh959697-${var.bucket_names[1]}"


  tags = {
    env = var.env
  }
}


# bool      -- uses true/false

variable "bucket_names" {
  type        = bool
  default = true                                     # if not present will ask value
  description = "This is a bool."                      #(optional)
}



# number

variable "bucket_names" {
  type        = number
  default = 10                                      # if not present will ask value
  description = "This is a number."                       #(optional)
}



# Map

variable "map_me" {
  type        = map
  default = {
     "name"        = "ujwesh"
     "place"        = "us-east-1"
     "animal"        = "lion"
     "thing"        = "mobile"
  }                                      # if not present will ask value
  description = "This is a map."                       #(optional)
}

# var.map_me            -- will take all values


# map(string)
# list(string)
# any