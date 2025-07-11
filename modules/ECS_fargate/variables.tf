
variable "cluster_name" {
  description = "name of the ECS cluster"
  type = string
}
variable "vpc_id" {
  description = "vpc id of the vpc created in vpc module"
  type = string
}

