data "terraform_remote_state" "network_state" {
  backend = "s3"

  config {
    bucket = "wasabi-terraform-state"
    key    = "aws/network/terraform.tfstate"
    region = "us-east-1"
  }
}
