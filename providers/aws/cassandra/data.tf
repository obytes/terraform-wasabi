data "terraform_remote_state" "network_state" {
  backend = "s3"

  config {
    bucket = "wasabi-terraform-state"
    key    = "aws/network/terraform.tfstate"
    region = "us-east-1"
  }
}
data "aws_subnet_ids" "private_subnets" {
  vpc_id = "${data.terraform_remote_state.network_state.vpc["vpc_id"]}"

  tags {
    Name = "${var.environment}-${var.name}-private-*"
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = "${data.terraform_remote_state.network_state.vpc["vpc_id"]}"

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