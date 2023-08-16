resource "aws_s3_bucket" "this" {
  count = length(var.bucket_name)  
  bucket = "${var.bucket_name[count.index]}-${var.env}"  # joining 2 variables is called concating
  
}