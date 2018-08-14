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