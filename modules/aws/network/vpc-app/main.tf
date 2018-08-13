data "aws_availability_zones" "available" {}

data "aws_region" "current" {
  current = true
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name  = "${var.name}-vpc"
    Stack = "${var.name}"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name_servers = [
    "AmazonProvidedDNS",
    "8.8.8.8",
  ]

  tags {
    Name  = "${var.name}-dhcp"
    Stack = "${var.name}"
  }
}

resource "aws_vpc_dhcp_options_association" "dhcp-assoc" {
  vpc_id          = "${aws_vpc.vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dhcp.id}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name  = "${var.name}-igw"
    Stack = "${var.name}"
  }
}

resource "aws_subnet" "private" {
  count = "${length(var.private_ranges)}"

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.private_ranges, count.index)}"
  availability_zone = "${element(var.zones[data.aws_region.current.name], count.index)}"

  tags {
    Name  = "${var.name}-private-${element(var.zones[data.aws_region.current.name], count.index)}"
    Stack = "${var.name}"
  }
}

resource "aws_subnet" "public" {
  count = "${length(var.public_ranges)}"

  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${element(var.public_ranges, count.index)}"
  availability_zone       = "${element(var.zones[data.aws_region.current.name], count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name  = "${var.name}-public-${element(var.zones[data.aws_region.current.name], count.index)}"
    Stack = "${var.name}"
  }
}

resource "aws_default_route_table" "public_rt" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  tags {
    Name  = "${var.name}-public-route-table"
    Stack = "${var.name}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name  = "${var.name}-private-route-table"
    Stack = "${var.name}"
  }
}

resource "aws_route_table_association" "rt_associate_public" {
  count          = "${length(var.public_ranges)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_default_route_table.public_rt.id}"
}

resource "aws_route_table_association" "rt_associate_private" {
  count          = "${length(var.private_ranges)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_route" "private_nat_gateway_route" {
  route_table_id = "${aws_route_table.private_rt.id}"

  depends_on = [
    "aws_route_table.private_rt",
  ]

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.gw.id}"
}

resource "aws_route" "public_internet_gateway_route" {
  route_table_id = "${aws_default_route_table.public_rt.id}"

  depends_on = [
    "aws_default_route_table.public_rt",
  ]

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${element(aws_subnet.public.*.id, 0)}"

  tags {
    Name = "${var.name}-nat"
  }
}

resource "aws_default_network_acl" "acl" {
  default_network_acl_id = "${aws_vpc.vpc.default_network_acl_id}"

  subnet_ids = [
    "${concat(aws_subnet.public.*.id, aws_subnet.private.*.id)}",
  ]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name  = "${var.name}-acl"
    Stack = "${var.name}"
  }
}
