data "aws_kms_key" "kms" {
  key_id = "alias/prod-kms"
}

data "aws_subnet_ids" "private_subnets" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.environment}-${var.name}-private-*"
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.environment}-${var.name}-public-*"
  }
}

data "aws_ami" "cassandra_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-linux-2018.03-cassandra"]
  }
}

data "aws_ami" "wasabi_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu-16.04-wasabi"]
  }
}
