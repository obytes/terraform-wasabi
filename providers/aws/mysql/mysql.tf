resource "aws_security_group" "default" {
  name        = "${var.environment}-${var.identifier}-sg"
  description = "Allow 3306 in VPC"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "TCP"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags {
    Name = "${var.environment}-${var.identifier}-sg"
  }
}

resource "aws_db_parameter_group" "default" {
  name   = "${var.environment}-${var.identifier}-param-group"
  family = "${var.family}"
}

resource "aws_db_instance" "default" {
  depends_on = [
    "aws_security_group.default",
  ]

  identifier                 = "${var.environment}-${var.identifier}"
  engine                     = "${var.engine}"
  engine_version             = "${var.engine_version}"
  instance_class             = "${var.db_type}"
  multi_az                   = "${var.multi_az}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"

  # disk
  storage_type      = "${var.storage_type}"
  iops              = "${var.iops}"
  allocated_storage = "${var.allocated_storage}"
  storage_encrypted = true
  kms_key_id        = "${data.aws_kms_key.kms.arn}"

  name                    = "${var.db_name}"
  username                = "${var.db_username}"
  password                = "${var.db_password}"
  backup_retention_period = "30"

  vpc_security_group_ids = [
    "${aws_security_group.default.id}",
  ]

  db_subnet_group_name = "${aws_db_subnet_group.default.id}"

  parameter_group_name = "${aws_db_parameter_group.default.id}"

  lifecycle {
    ignore_changes = [
      "password",
      "parameter_group_name",
      "tags",
    ]
  }
}

resource "aws_db_subnet_group" "default" {
  name        = "${var.environment}-${var.identifier}-subnet-group"
  description = "Main group of subnets for ${var.environment}-${var.identifier}"

  subnet_ids = [
    "${data.aws_subnet_ids.private_subnets.ids}",
  ]
}
