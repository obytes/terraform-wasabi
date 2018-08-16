resource "aws_network_interface" "az1_cassandra_seed_eni" {
  description     = "az1_cassandra_seed_1_eni"
  subnet_id       = "${var.private_subnets[1]}"
  private_ips     = ["${var.private_ip1}"]
  security_groups = ["${aws_security_group.cassandra_private_sg.id}"]

  tags {
    Name = "${var.seed_tag}"
  }
}

resource "aws_network_interface" "az2_cassandra_seed_eni" {
  description     = "az2_cassandra_seed_2_eni"
  subnet_id       = "${var.private_subnets[0]}"
  private_ips     = ["${var.private_ip2}"]
  security_groups = ["${aws_security_group.cassandra_private_sg.id}"]

  tags {
    Name = "${var.seed_tag}"
  }
}
