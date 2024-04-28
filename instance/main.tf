provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "test" {
    tags = {
      name = "first-instance"
    }
    instance_type = "t2.micro"
    ami = "ami-069d73f3235b535bd"
}