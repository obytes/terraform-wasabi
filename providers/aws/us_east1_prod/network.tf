module "network" {
  source         = "../../../modules/aws/network/vpc-app"
  name           = "${var.environment}-${var.name}"
  cidr_block     = "${var.cidr_block}"
  public_ranges  = "${var.public_ranges}"
  private_ranges = "${var.private_ranges}"
}
