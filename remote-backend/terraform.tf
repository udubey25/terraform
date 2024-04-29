terraform {
  backend "s3" {
    bucket         = "utkarsh-terra-state-file"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terra-state-file-locks"
    encrypt        = true
  }
}