provider "aws" {
      region = var.region
}

resource "aws_s3_bucket" "remote-backend" {
    bucket = "${var.region}-aws-s3bucket"
    lifecycle {
      prevent_destroy = false
    }
}

resource "aws_s3_bucket_versioning" "remote-backend-vers-Enabled" {
    bucket = aws_s3_bucket.remote-backend.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-encryption" {
    bucket = aws_s3_bucket.remote-backend.id
    rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_public_access_block" "access-conf" {
    bucket = aws_s3_bucket.remote-backend.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_dynamodb_table" "state-file-lock" {
    name = "${var.region}-aws-dynamodb"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
  
}