# Define security group for cassandra  cluster

resource "aws_security_group" "cassandra_private_sg" {
  name   = "${var.environment}-${var.name}-cassandra-private-sg"
  vpc_id = "${var.vpc}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "TCP"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 7000
    to_port   = 7000
    protocol  = "TCP"

    cidr_blocks = [
      "10.241.110.0/24",
      "10.241.111.0/24",
    ]
  }

  ingress {
    from_port = 7001
    to_port   = 7001
    protocol  = "TCP"

    cidr_blocks = [
      "10.241.110.0/24",
      "10.241.111.0/24",
    ]
  }

  ingress {
    from_port = 7199
    to_port   = 7199
    protocol  = "TCP"

    cidr_blocks = [
      "10.241.110.0/24",
      "10.241.111.0/24",
    ]
  }

  ingress {
    from_port = 9042
    to_port   = 9042
    protocol  = "TCP"

    cidr_blocks = [
      "10.241.110.0/24",
      "10.241.111.0/24",
      "10.241.100.0/24",
      "10.241.101.0/24",
    ]
  }

  ingress {
    from_port = 9160
    to_port   = 9160
    protocol  = "TCP"

    cidr_blocks = [
      "10.241.110.0/24",
      "10.241.111.0/24",
      "10.241.100.0/24",
      "10.241.101.0/24",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-${var.name}-cassandra-private-sg"
  }
}
