provider "aws" {
  region  = "${var.region}"
  profile = "${var.aws_profile}"
  version = "~> 1.27.0"
}

provider "template" {
  version = "~> 1.0.0"
}

terraform {
  backend "s3" {
    bucket     = "wasabi-terraform-state"
    key        = "aws/mysql/terraform.tfstate"
    region     = "us-east-1"
  }

  required_version = "= 0.11.6"
}
