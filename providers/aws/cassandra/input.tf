#============#
#   Common   #
#============#

variable "region" {}

variable "aws_profile" {}

variable "environment" {}

variable "name" {}

variable "key_name" {}

#========================#
#    Wasabi-Cassandra    #
#========================#

variable "tag" {}

variable "seed_tag" {}

variable "azs" {
  type = "list"
}

variable "cassandra_instance_type" {}

variable "as_min_size" {}

variable "as_max_size" {}

variable "ebs_size" {}

variable "ebs_type" {}

variable "cassandra_user" {}

variable "cassandra_pass" {}

variable "cassandra_datacenter" {}