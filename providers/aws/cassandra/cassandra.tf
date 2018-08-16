module "cassandra" {
  source = "../../../modules/aws/cassandra"

  # Common
  environment     = "${var.environment}"
  name            = "${var.name}"
  region          = "${var.region}"
  key_name        = "${var.key_name}"
  vpc             = "${data.terraform_remote_state.network_state.vpc["vpc_id"]}"
  private_subnets = "${data.aws_subnet_ids.private_subnets.ids}"
  public_subnets  = "${data.aws_subnet_ids.public_subnets.ids}"


  # Cassandra
  tag                     = "${var.tag}"
  seed_tag                = "${var.seed_tag}"
  azs                     = "${var.azs}"
  cassandra_ami           = "${data.aws_ami.cassandra_ami.image_id}"
  cassandra_instance_type = "${var.cassandra_instance_type}"
  as_min_size             = "${var.as_min_size}"
  as_max_size             = "${var.as_max_size}"
  ebs_size                = "${var.ebs_size}"
  ebs_type                = "${var.ebs_type}"
  cassandra_user          = "${var.cassandra_user}"
  cassandra_pass          = "${var.cassandra_pass}"
  cassandra_datacenter    = "${var.cassandra_datacenter}"
}
