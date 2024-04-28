provider "aws" {
  region = "us-east-1"

}

resource "aws_s3_bucket" "first-bucket" {
  bucket = "bucket-for-interview"
  acl    = "public-read"
  versioning {
    enabled = "true"
  }
  lifecycle_rule {
    id      = "log"
    enabled = "true"
    prefix  = "log/"
    transition {
      days          = 35
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 65
      storage_class = "GLACIER"
    }
    expiration {
      days = 90
    }
  }
}
