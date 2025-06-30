#terraform {
 # backend "s3" {
  #  bucket         = "ap-southeast-2-aws-s3bucket"
   # key            = "global/terraform.tfstate"
    #dynamodb_table = "ap-southeast-2-aws-dynamodb"
    #region = "ap-southeast-2"
  #}
#}


terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}