# Common

variable "environment" {}
variable "name" {}
variable "region" {}
variable "key_name" {}
variable "vpc" {}

variable "private_subnets" {
  type = "list"
}

variable "public_subnets" {
  type = "list"
}

# Cassandra 

variable "tag" {}
variable "seed_tag" {}

variable "azs" {
  type = "list"
}

variable "private_ip1" {
  default = {
    us-east-1 = "10.241.110.50"
    us-west-2 = "10.245.111.50"
  }
}

variable "private_ip2" {
  default = {
    us-east-1 = "10.241.111.50"
    us-west-2 = "10.245.110.50"
  }
}

variable "cassandra_ami" {}
variable "cassandra_instance_type" {}
variable "as_min_size" {}
variable "as_max_size" {}
variable "elb_sg" {}
variable "ebs_size" {}
variable "ebs_type" {}
variable "cassandra_user" {}
variable "cassandra_pass" {}
variable "cassandra_datacenter" {}
