resource "aws_vpc" "first-vpc" {
    cidr_block = "192.18.0.0/16"
    tags = {
      app = "flask-app"
      name = "flask-app-vpc"
    }
}

resource "aws_subnet" "public-subnet" {
    cidr_block = "192.18.10.0/24"
    availability_zone = "ap-southeast-2a"
    vpc_id = aws_vpc.first-vpc.id
    map_public_ip_on_launch = true
    tags = {
      name = "public-subnet"
    }
}

resource "aws_subnet" "private-subnet" {
    cidr_block = "192.18.11.0/24"
    availability_zone = "ap-southeast-2b"
    vpc_id = aws_vpc.first-vpc.id
    tags = {
      name = "private-subnet"
    }
}

resource "aws_internet_gateway" "gw-public" {
  vpc_id = aws_vpc.first-vpc.id
  tags = {
    name = "main-gw"
  }  
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.first-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-public.id
  }
}


