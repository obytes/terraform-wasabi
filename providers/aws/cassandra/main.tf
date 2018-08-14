provider "aws" {
  region  = "${var.region}"
  profile = "${var.aws_profile}"
  version = "~> 1.27.0"
}

provider "template" {
  version = "~> 1.0.0"
}

terraform {
  required_version = "= 0.11.6"
}
