provider "aws" {
  region = var.reg
}

resource "aws_vpc" "utkarsh-vpc" {
  cidr_block = "192.16.0.0/16"
  tags = {
    app="web-server"
  }
}

resource "aws_subnet" "utkarsh-vpc-subnet" {
    cidr_block = "192.16.10.0/24"
    availability_zone = "${var.reg}a"
    vpc_id = aws_vpc.utkarsh-vpc.id
}

resource "aws_instance" "name" {
    tags = {
        name="web-server"
    } 
    instance_type = var.instace_type
    ami = var.ami-id
    root_block_device {
      volume_size = 10
      volume_type  = "gp3"
    }
    subnet_id = aws_subnet.utkarsh-vpc-subnet.id
}