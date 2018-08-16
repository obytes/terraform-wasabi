#============#
#   Common   #
#============#

region = "us-east-1"

environment = "prod"

name = "wasabi"

key_name = "prod-wasabi-key"

#==================#
#    Wasabi-APP    #
#==================#

wasabi_ami = "ami-12345678"

wasabi_instance_type = "t2.medium"

wasabi_min_size = "2"

wasabi_max_size = "4"

wasabi_asg_desired_capacity = "2"
