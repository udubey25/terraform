provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "remote-backend" {
  bucket = "vars-in-${var.region}"
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "vers_enabled" {
  bucket = aws_s3_bucket.remote-backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public-access-block" {
  bucket                  = aws_s3_bucket.remote-backend.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "serv-side-conf" {
  bucket = aws_s3_bucket.remote-backend.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "remote-lock" {
  name         = "remote-lock-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
