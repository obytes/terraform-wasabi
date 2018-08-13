output "vpc" {
  value = "${
    map(
      "vpc_id", "${aws_vpc.vpc.id}",
      "cidr_block", "${aws_vpc.vpc.cidr_block}"
    )
  }"
}

output "private_subnet_ids" {
  value = [
    "${aws_subnet.private.*.id}",
  ]
}

output "public_subnet_ids" {
  value = [
    "${aws_subnet.public.*.id}",
  ]
}

output "private_subnet_azs" {
  value = [
    "${aws_subnet.private.*.availability_zone}",
  ]
}

output "public_subnet_azs" {
  value = [
    "${aws_subnet.public.*.availability_zone}",
  ]
}

output "nat_ip" {
  value = "${aws_eip.eip.public_ip}"
}
