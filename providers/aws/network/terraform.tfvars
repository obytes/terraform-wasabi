#============#
#   Common   #
#============#

region = "us-east-1"

environment = "prod"

name = "wasabi"

#=========#
#   VPC   #
#=========#
cidr_block = "10.241.0.0/16"

public_ranges = [
  "10.241.100.0/24",
  "10.241.101.0/24",
]

private_ranges = [
  "10.241.110.0/24",
  "10.241.111.0/24",
]