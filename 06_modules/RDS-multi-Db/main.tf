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


# Create an RDS instance
resource "aws_db_instance" "instance1" {
  count                = length(var.engine)

  allocated_storage    = var.allocated-storage
  storage_type         = var.storage-type
  engine               = element(var.engine, count.index)
#   engine_version       = var.engine-version
  instance_class       = var.instance-class
  identifier           = format("%s-%s", element(var.identifier, count.index), var.env)
  username             = var.username
  password             = var.password
  skip_final_snapshot  = var.skip-final-snapshot
  publicly_accessible  = var.publicly-accessible
  availability_zone    = var.availability-zone
}

# # Create multiple databases inside the RDS instance
# resource "aws_db_instance" "example_secondary_db" {
#   allocated_storage    = 10
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t2.micro"
#   name                 = "example-secondary-db"
#   username             = "admin"
#   password             = "your-password-here"
#   skip_final_snapshot  = true
#   publicly_accessible  = false
#   depends_on           = [aws_db_instance.example]  # Ensure the primary instance is created first

#   # Connect to the primary RDS instance
#   provisioner "remote-exec" {
#     inline = [
#       "mysql -h ${aws_db_instance.example.endpoint} -u admin -p'your-password-here' -e 'CREATE DATABASE secondary_db;'",
#     ]
#   }
# }

# # Output the connection details
# output "db_endpoint" {
#   value = aws_db_instance.example.endpoint
# }
