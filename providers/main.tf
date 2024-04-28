provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "first-vpc" {
    cidr_block = "192.16.0.0/16"
    tags = {
      app = "web-server"
    }
}

resource "aws_subnet" "first-subnet" {
    cidr_block = "192.16.10.0/24"
    availability_zone = "us-east-1a"
    vpc_id = aws_vpc.first-vpc.id
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "first-ec2" {
    tags = {
      name= "jump-server"
    }
    ami = "ami-06ca3ca175f37dd66"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.first-subnet.id
}
