#============#
#   Common   #
#============#

region = "us-east-1"

environment = "prod"

name = "wasabi"

key_name = "prod-wasabi-key"


#==================#
#    Wasabi-RDS    #
#==================#

allocated_storage = "50"

db_name = "wasabi"

db_username = "wasabi"

db_password = "wasabi"

db_type = "db.t2.large"

auto_minor_version_upgrade = "false"

engine = "mysql"

engine_version = "5.6.39"

family = "mysql5.6"

identifier = "mysql-wasabi"

storage_type = "gp2"

iops = "0"

multi_az = "true"