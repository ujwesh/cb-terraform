#provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

}


# S3 bucket:-

resource "aws_s3_bucket" "s3" {
  bucket = var.bucket-name
  acl    = var.acl-access

  versioning {
    enabled = var.bucket-versioning
  }

  tags = {
    Name = format("%s-%s", var.bucket-name, var.env)
  }
}


# static website hosting:-

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.s3.id

  index_document {
    suffix = "index.html"
  }
}


# bucket public/private:-

resource "aws_s3_bucket_public_access_block" "public-access" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = var.block-public-acls
  block_public_policy     = var.block-public-policy
  ignore_public_acls      = var.ignore-public-acls
  restrict_public_buckets = var.restrict-public-buckets
}



# bucket object add:-

resource "aws_s3_object" "s3-object" {
  bucket = aws_s3_bucket.s3.id
  key    = "index.html" # Object key
  source = "/home/ujwesh/13_terraform/06_modules//s3+CF/index.html"
  #   content_type = "text/html"  # Specify the content type (optional)
}


# custom bucket policy for make public & give only read access:-

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "PublicReadGetObject",
        Effect = "Allow",
        Action = "s3:GetObject",
        Principal : "*",
        Resource = "${aws_s3_bucket.s3.arn}/*"
      }
    ]
  })
}


## CF

resource "aws_cloudfront_origin_access_control" "example" {
  name                              = "example"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}



resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.s3.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.example.id
    origin_id                = "s3-website-origin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "For s3 distribution"
  default_root_object = "index.html"

#   logging_config {
#     include_cookies = false
#     bucket          = "mylogs.s3.amazonaws.com"
#     prefix          = "myprefix"
#   }

#   aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = [ "GET", "HEAD",]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-website-origin"

    viewer_protocol_policy = "redirect-to-https"
    min_ttl               = 0
    default_ttl           = 3600
    max_ttl               = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


  