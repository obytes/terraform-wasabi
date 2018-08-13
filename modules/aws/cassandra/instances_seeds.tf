data "template_file" "user_data_seeds" {
  template = "${file("${path.module}/files/cluster_config.sh")}"

  vars {
    CASSANDRA_USER       = "${var.cassandra_user}"
    CASSANDRA_PASS       = "${var.cassandra_pass}"
    ENV                  = "${var.environment}"
    CASSANDRA_DATACENTER = "${var.cassandra_datacenter}"
  }
}

resource "aws_instance" "az1_cassandra_seed" {
  ami               = "${var.cassandra_ami}"
  instance_type     = "${var.cassandra_instance_type}"
  key_name          = "${var.key_name}"
  availability_zone = "${var.azs[0]}"

  network_interface {
    network_interface_id = "${aws_network_interface.az1_cassandra_seed_eni.id}"
    device_index         = 0
  }

  user_data = "${data.template_file.user_data_seeds.rendered}"

  tags {
    Name = "${var.environment}-${var.name}-${var.seed_tag}"
  }

  root_block_device {
    volume_size           = "${var.ebs_size}"
    volume_type           = "${var.ebs_type}"
    delete_on_termination = false
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }
}

resource "aws_instance" "az2_cassandra_seed" {
  ami               = "${var.cassandra_ami}"
  instance_type     = "${var.cassandra_instance_type}"
  key_name          = "${var.key_name}"
  availability_zone = "${var.azs[1]}"

  network_interface {
    network_interface_id = "${aws_network_interface.az2_cassandra_seed_eni.id}"
    device_index         = 0
  }

  user_data = "${data.template_file.user_data_seeds.rendered}"

  tags {
    Name = "${var.environment}-${var.name}-${var.seed_tag}"
  }

  root_block_device {
    volume_size           = "${var.ebs_size}"
    volume_type           = "${var.ebs_type}"
    delete_on_termination = false
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }
}
