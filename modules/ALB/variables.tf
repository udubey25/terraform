variable "security_groups" {
  description = "list of security groups"
  type = list(string)
  
}
variable "subnets" {
  description = "list of subnet ids"
  type = list(string)
}

variable "vpc_id" {
  description = "the id of the vpc created in the vpc module"
  type = string
}