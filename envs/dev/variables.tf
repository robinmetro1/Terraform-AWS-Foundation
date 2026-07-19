variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3" # Paris
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "eya-foundation"
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
  description = "AZs for the subnets"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b"]
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
