# Remote state backend (S3 + DynamoDB lock).
#
# NOTE: backend blocks cannot use variables, so these values are hardcoded.
# 1) First run the ./bootstrap config once to create the bucket + table.
# 2) Then paste the bootstrap outputs here (bucket + dynamodb_table).
# 3) Run `terraform init` in this dir to migrate state to S3.

terraform {
  backend "s3" {
    bucket         = "eya-tf-state-CHANGE-ME-1234" # <-- from bootstrap output
    key            = "dev/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "eya-tf-locks"
    encrypt        = true
  }
}
