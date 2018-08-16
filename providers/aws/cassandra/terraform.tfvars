#============#
#   Common   #
#============#

region = "us-east-1"

environment = "prod"

name = "wasabi"

key_name = "prod-wasabi-key"

#========================#
#    Wasabi-Cassandra    #
#========================#

tag = "cassandra"

seed_tag = "cassandra-seed"

azs = ["us-east-1a", "us-east-1c"]

cassandra_ami = "ami-0423e3f8435107f34"

cassandra_instance_type = "m4.large"

as_min_size = "4"

as_max_size = "4"

ebs_size = "200"

ebs_type = "gp2"

cassandra_user = "cassandra"

cassandra_pass = "cassandra"

cassandra_datacenter = "us-east"