#============#
#   Common   #
#============#

region = "us-east-1"

aws_profile = "aws"

environment = "prod"

name = "wasabi"

key_name = "prod-wasabi-key"

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

#========================#
#    Wasabi-Cassandra    #
#========================#

tag = "cassandra"

seed_tag = "cassandra-seed"

azs = ["us-east-1a", "us-east-1c"]

cassandra_ami = "ami-12345678"

cassandra_instance_type = "m4.large"

as_min_size = "4"

as_max_size = "4"

ebs_size = "200"

ebs_type = "gp2"

cassandra_user = "cassandra"

cassandra_pass = ""

cassandra_datacenter = "us-east"

#==================#
#    Wasabi-RDS    #
#==================#

allocated_storage = "50"

db_name = "wasabi"

db_username = "wasabi"

db_password = ""

db_type = "db.t2.large"

auto_minor_version_upgrade = "false"

engine = "mysql"

engine_version = "5.6.39"

family = "mysql5.6"

identifier = "mysql-wasabi"

storage_type = "gp2"

iops = "0"

multi_az = "true"

#==================#
#    Wasabi-APP    #
#==================#

wasabi_ami = "ami-12345678"

wasabi_instance_type = "t2.medium"

wasabi_min_size = "2"

wasabi_max_size = "4"

wasabi_asg_desired_capacity = "2"
