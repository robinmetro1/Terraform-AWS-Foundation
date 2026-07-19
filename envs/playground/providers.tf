# Playground environment — for ephemeral sandboxes (KodeKloud, etc.).
# NOTE: no backend.tf here on purpose. State stays LOCAL, because a throwaway
# sandbox has nothing to persist and no S3 bucket to point at.

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "terraform-aws-foundation"
      Environment = "playground"
      ManagedBy   = "terraform"
      Owner       = "eya"
    }
  }
}
