provider "aws" {

}

resource "aws_instance" "web" {
  # count = 2
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    # Name = "ujwesh-${count.index + 1}"
    Name = "ujwesh"
  }
}