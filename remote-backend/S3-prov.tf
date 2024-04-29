provider "aws" {
  region = "ap-south-1"
}
#creating s3 bucket
resource "aws_s3_bucket" "terra-state" {
  bucket = "utkarsh-terra-state-file"
  lifecycle {
    prevent_destroy = true
  }
}
#enabling versioning
resource "aws_s3_bucket_versioning" "vers-enabl" {
  bucket = aws_s3_bucket.terra-state.id
  versioning_configuration {
    status = "Enabled"
  }
}
#enabling encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-encryp" {
  bucket = aws_s3_bucket.terra-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
#restricting public access
resource "aws_s3_bucket_public_access_block" "bucket-pubaccess" {
  bucket                  = aws_s3_bucket.terra-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
#create dynamodb for locking
resource "aws_dynamodb_table" "terra-locks" {
  name         = "terra-state-file-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "aws-s3-bucket-id" {
  value = aws_s3_bucket.terra-state.arn
}
output "aws-s3-dynamodb-id" {
  value = aws_dynamodb_table.terra-locks.arn
}