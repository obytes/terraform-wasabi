#============#
#   Common   #
#============#

variable "region" {}

variable "aws_profile" {}

variable "environment" {}

variable "name" {}

#=========#
#   VPC   #
#=========#
variable "cidr_block" {}

variable "public_ranges" {
  type = "list"
}

variable "private_ranges" {
  type = "list"
}