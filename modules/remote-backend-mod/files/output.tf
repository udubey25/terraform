output "bucket-id" {
    value = aws_s3_bucket.remote-backend.id

}

output "aws_s3_bucket_lifecycle" {
    value = aws_s3_bucket.remote-backend.policy
  
}
output "aws_dynamodb_table-id" {
    value = aws_dynamodb_table.state-file-lock.id
}

