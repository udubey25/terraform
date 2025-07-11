output "aws_internet_gateway"{
  value = aws_internet_gateway.gw-public.id
}

output "vpc_id"{
  value = aws_vpc.first-vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public-subnet.id  
}
output "private_subnet_ids" {
  value = aws_subnet.private-subnet.id
}