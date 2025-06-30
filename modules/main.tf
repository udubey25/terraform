provider "aws" {
  region = "ap-southeast-2"
}

# Initially run local to provision backend resources:
module "remote_backend" {
  source = "./remote-backend-mod"
  region = "ap-southeast-2"
}
module "vpc" {
  source = "./assignment"
  # pass variables here
}