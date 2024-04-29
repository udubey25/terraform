provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "test" {
    tags = {
      name = "first-instance"
    }
    instance_type = "t2.micro"
    ami = "ami-069d73f3235b535bd"
}