data "template_file" "user_data_non_seeds" {
  template = "${file("${path.module}/files/cluster_config_non_seeds.sh")}"

  vars {
    CASSANDRA_USER       = "${var.cassandra_user}"
    CASSANDRA_PASS       = "${var.cassandra_pass}"
    ENV                  = "${var.environment}"
    CASSANDRA_DATACENTER = "${var.cassandra_datacenter}"
  }
}

resource "aws_launch_configuration" "cassandra_lc" {
  name            = "${var.environment}-${var.name}-cassandra_lc"
  image_id        = "${var.cassandra_ami}"
  instance_type   = "${var.cassandra_instance_type}"
  key_name        = "${var.key_name}"
  security_groups = ["${aws_security_group.cassandra_private_sg.id}"]
  user_data       = "${data.template_file.user_data_non_seeds.rendered}"

  root_block_device {
    volume_size           = "${var.ebs_size}"
    volume_type           = "${var.ebs_type}"
    delete_on_termination = false
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }
}

resource "aws_autoscaling_group" "cassndra_as" {
  name                 = "${var.environment}-${var.name}-cassandra-as"
  vpc_zone_identifier  = ["${var.private_subnets}"]
  launch_configuration = "${aws_launch_configuration.cassandra_lc.name}"
  min_size             = "${var.as_min_size}"
  max_size             = "${var.as_max_size}"

  load_balancers = ["${aws_elb.cassandra_elb.id}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-${var.name}-cassandra-non-seed"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cassandra_as_policy" {
  name            = "${var.environment}-${var.name}-cassandra-as-policy"
  adjustment_type = "ChangeInCapacity"

  autoscaling_group_name  = "${aws_autoscaling_group.cassndra_as.name}"
  policy_type             = "StepScaling"
  metric_aggregation_type = "Average"

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = 50
  }

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 50
  }
}
