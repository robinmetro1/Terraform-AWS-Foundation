output "state_bucket_name" {
  description = "Name of the S3 bucket holding Terraform state"
  value       = aws_s3_bucket.tf_state.id
}

output "lock_table_name" {
  description = "Name of the DynamoDB lock table"
  value       = aws_dynamodb_table.tf_locks.name
}

output "backend_config_hint" {
  description = "Copy these values into envs/dev/backend.tf"
  value       = <<-EOT
    bucket         = "${aws_s3_bucket.tf_state.id}"
    dynamodb_table = "${aws_dynamodb_table.tf_locks.name}"
    region         = "${var.region}"
  EOT
}
