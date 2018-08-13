module "wasabi" {
  source = "../../../modules/aws/stacks/wasabi/"

  # Common
  environment = "${var.environment}"
  name        = "${var.name}"
  region      = "${var.region}"
  key_name    = "${var.key_name}"
  vpc_id      = "${module.network.vpc["vpc_id"]}"

  # Cassandra
  tag                     = "${var.tag}"
  seed_tag                = "${var.seed_tag}"
  azs                     = "${var.azs}"
  cassandra_instance_type = "${var.cassandra_instance_type}"
  as_min_size             = "${var.as_min_size}"
  as_max_size             = "${var.as_max_size}"
  ebs_size                = "${var.ebs_size}"
  ebs_type                = "${var.ebs_type}"
  cassandra_user          = "${var.cassandra_user}"
  cassandra_pass          = "${var.cassandra_pass}"
  cassandra_datacenter    = "${var.cassandra_datacenter}"

  # RDS
  allocated_storage          = "${var.allocated_storage}"
  db_name                    = "${var.db_name}"
  db_username                = "${var.db_username}"
  db_password                = "${var.db_password}"
  db_type                    = "${var.db_type}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  engine                     = "${var.engine}"
  engine_version             = "${var.engine_version}"
  family                     = "${var.family}"
  identifier                 = "${var.identifier}"
  storage_type               = "${var.storage_type}"
  iops                       = "${var.iops}"
  multi_az                   = "${var.multi_az}"

  # Wasabi
  wasabi_instance_type        = "${var.wasabi_instance_type}"
  wasabi_min_size             = "${var.wasabi_min_size}"
  wasabi_max_size             = "${var.wasabi_max_size}"
  wasabi_asg_desired_capacity = "${var.wasabi_asg_desired_capacity}"
}
