provider "aws" {
  region = var.region
}

module "remote-backend" {
    source = "./files"
    region = var.region
}