variable "name" {
  description = "VPC name"
}

variable "cidr_block" {
  description = "VPC CIDR"
}

variable "public_ranges" {
  description = "Public subnet IP ranges (comma separated)"
  type        = "list"
}

variable "private_ranges" {
  description = "Private subnet IP ranges (comma separated)"
  type        = "list"
}

variable "zones" {
  description = "AZs for subnets"
  type        = "map"

  default = {
    "us-east-1" = ["us-east-1a"]
  }
}
