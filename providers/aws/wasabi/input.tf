#============#
#   Common   #
#============#

variable "region" {}

variable "aws_profile" {}

variable "environment" {}

variable "name" {}

variable "key_name" {}

#==================#
#    Wasabi-APP    #
#==================#

variable "wasabi_ami" {}

variable "wasabi_instance_type" {}

variable "wasabi_min_size" {}

variable "wasabi_max_size" {}

variable "wasabi_asg_desired_capacity" {}