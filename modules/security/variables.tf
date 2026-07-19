variable "name" {
  description = "Name prefix for security resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC in which to create the security group"
  type        = string
}

variable "allowed_cidrs" {
  description = "CIDR blocks allowed for inbound HTTP/HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Extra tags applied to all resources"
  type        = map(string)
  default     = {}
}
