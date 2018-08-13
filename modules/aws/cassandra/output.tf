output "cassandra_elb_name" {
  value = "${aws_elb.cassandra_elb.dns_name}"
}
