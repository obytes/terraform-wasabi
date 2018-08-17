resource "aws_launch_configuration" "wasabi_lc" {
  name_prefix   = "${var.environment}-${var.name}-wasabi-lc_"
  image_id      = "${var.wasabi_ami}"
  instance_type = "${var.wasabi_instance_type}"
  key_name      = "${var.key_name}"

  security_groups = [
    "${aws_security_group.wasabi_sg.id}",
  ]

  iam_instance_profile = "${var.environment}-wasabi-profile"
  enable_monitoring    = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "wasabi_create_asg" {
  depends_on = ["aws_launch_configuration.wasabi_lc"]
  name       = "${var.environment}-${var.name}-wasabi-asg"

  launch_configuration = "${aws_launch_configuration.wasabi_lc.name}"
  force_delete         = true
  vpc_zone_identifier  = [""]
  min_size             = "${var.wasabi_min_size}"
  max_size             = "${var.wasabi_max_size}"
  desired_capacity     = "${var.wasabi_asg_desired_capacity}"

  tag {
    key                 = "Name"
    value               = "${var.environment}-${var.name}-wasabi"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "wasabi_sg" {
  name        = "${var.environment}-${var.name}-wasabi-sg"
  vpc_id      = "${data.terraform_remote_state.network_state.vpc["vpc_id"]}"
  description = "Security Group for Wasabi instances"

  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    self      = true
  }

  ingress {
    protocol        = "tcp"
    from_port       = 8080
    to_port         = 8080
    security_groups = ["${aws_security_group.wasabi_alb_sg.id}"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags {
    Name        = "${var.environment}-wasabi-sg"
    Environment = "${var.environment}"
  }
}

resource "aws_alb" "wasabi_alb" {
  idle_timeout    = 60
  internal        = false
  name            = "${var.environment}-${var.name}-wasabi-alb"
  security_groups = ["${aws_security_group.wasabi_alb_sg.id}"]
  subnets         = [""]

  enable_deletion_protection = false

  tags {
    Name        = "${var.environment}-${var.name}-wasabi-alb"
    environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "wasabi" {
  load_balancer_arn = "${aws_alb.wasabi_alb.id}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.wasabi.id}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "wasabi" {
  name = "${var.environment}-${var.name}-wasabi-alb-tg"

  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${data.terraform_remote_state.network_state.vpc["vpc_id"]}"

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    path     = "/api/v1/ping"
    protocol = "HTTP"
    port     = 8080
    matcher  = "200,301,302"
  }

  tags {
    Name        = "${var.environment}-${var.name}-wasabi-alb-tg"
    environment = "${var.environment}"
  }
}

resource "aws_security_group" "wasabi_alb_sg" {
  name        = "${var.environment}-${var.name}-wasabi-alb-sg"
  vpc_id      = "${data.terraform_remote_state.network_state.vpc["vpc_id"]}"
  description = "Security Group for the Wasabi ALB"

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}-${var.name}-wasabi-alb-sg"
    Environment = "${var.environment}"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.wasabi_create_asg.id}"
  alb_target_group_arn   = "${aws_alb_target_group.wasabi.arn}"
}
