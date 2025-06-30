output "aws_internet_gateway"{
  value = aws_internet_gateway.gw-public.id
}

output "aws_vpc"{
  value = aws_vpc.first-vpc.id
}