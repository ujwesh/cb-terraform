provider "aws" {

}

resource "aws_s3_bucket" "s3-bucket" {
  count = 5
  bucket = "ujwesh9561766731-${count.index + 1}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}