variable "region" {
  description = "Select region in which to deploy between us-east-1 and us-east-2"
}

variable "instance_type" {
  type = map(any)
  default = {
    "us-east-1" = "t2.nano"
    "us-west-1" = "t2.micro"
  }
}