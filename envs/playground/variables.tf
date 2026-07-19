# Defaults are tuned for a KodeKloud AWS sandbox (locked to us-east-1).
# You should not need a terraform.tfvars file at all — just init + apply.

variable "region" {
  description = "AWS region (KodeKloud sandboxes are almost always us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "eya-playground"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs (one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "AZs for the subnets (must exist in var.region)"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "allowed_cidrs" {
  description = "CIDRs allowed inbound on HTTP/HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}
