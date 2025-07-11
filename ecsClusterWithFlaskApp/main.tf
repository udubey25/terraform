provider "aws" {
  region = "ap-southeast-2"
}

# Initially run local to provision backend resources:
module "remote_backend" {
  source = "git::https://github.com/udubey25/terraform.git//modules/remote-backend-mod?ref=main"
  region = "ap-southeast-2"
}
module "vpc" {
  source = "git::https://github.com/udubey25/terraform.git//modules/VPC?ref=main"
}

module "ECS_fargate" {
  source = "git::https://github.com/udubey25/terraform.git//modules/ECS_fargate?ref=main"
  cluster_name = "flask-app-cluster"
  vpc_id = "module.vpc.vpc_id"
}

module "alb" {
  source = "git::https://github.com/udubey25/terraform.git//modules/ALB?ref=main"
  security_groups = ["module.ECS_fargate.ecs-sg"]
  subnets = ["module.vpc.public_subnet_ids"]
  vpc_id = "module.vpc.vpc_id"
}



