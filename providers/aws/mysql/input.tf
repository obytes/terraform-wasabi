#============#
#   Common   #
#============#

variable "region" {}

variable "aws_profile" {}

variable "environment" {}

variable "name" {}

variable "key_name" {}

#====================#
#    Wasabi-MySQL    #
#====================#
variable "allocated_storage" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "db_type" {}
variable "auto_minor_version_upgrade" {}
variable "engine" {}
variable "engine_version" {}
variable "family" {}
variable "identifier" {}

variable "storage_type" {}

variable "iops" {}

variable "multi_az" {}