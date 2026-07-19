variable "region" {
  description = "AWS region for the state backend"
  type        = string
  default     = "eu-west-3" # Paris
}

variable "state_bucket_name" {
  description = "Globally-unique S3 bucket name for Terraform state"
  type        = string
}

variable "lock_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "eya-tf-locks"
}
