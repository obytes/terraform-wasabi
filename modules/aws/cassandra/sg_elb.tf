resource "aws_security_group" "cassandra_elb_sg" {
  name   = "${var.environment}-${var.name}-cassandra-elb-sg"
  vpc_id = "${var.vpc}"

  ingress {
    from_port       = 9042
    to_port         = 9042
    protocol        = "tcp"
    security_groups = ["${var.elb_sg}"]
  }

  ingress {
    from_port       = 9160
    to_port         = 9160
    protocol        = "tcp"
    security_groups = ["${var.elb_sg}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-${var.name}-cassandra-elb-sg"
  }
}
