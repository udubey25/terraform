resource "aws_instance" "test-instance" {
  instance_type = "t2.micro"
  tags = {
    name = "test-instance"
  }
  ami = "ami-069d73f3235b535bd"
}