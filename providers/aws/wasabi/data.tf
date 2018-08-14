data "aws_ami" "wasabi_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu-16.04-wasabi"]
  }
}
