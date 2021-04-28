#--------------------------------------------------------------
# This module creates all resources necessary for subnets
#--------------------------------------------------------------
locals {
  number_subnets = length(split(",", var.subnet_cidrs))
}

resource "aws_subnet" "default" {
  vpc_id                  = var.vpc_id
  cidr_block              = element(split(",", var.subnet_cidrs), count.index)
  availability_zone       = element(split(",", var.azs), count.index)
  count                   = length(split(",", var.subnet_cidrs))
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      "Name" = format("${var.subnet_name}-%d", count.index)
      "az"   = element(split(",", var.azs), count.index)
    },
    var.subnet_tags,
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "default" {

  count  = local.number_subnets
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = var.subnet_name
      "az"   = element(split(",", var.azs), count.index)
    },
    var.subnet_tags,
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "nat_gateway" {

  count                  = var.nat_gateway_ids != [] ? local.number_subnets : 0
  route_table_id         = element(aws_route_table.default.*.id, count.index)
  nat_gateway_id         = element(var.nat_gateway_ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.default]
}

resource "aws_route" "nat_instance" {

  count                  = var.instance_ids != [] ? local.number_subnets : 0
  route_table_id         = element(aws_route_table.default.*.id, count.index)
  instance_id            = element(var.instance_ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.default]
}

resource "aws_route" "gateway_id" {

  count                  = var.gateway_ids != [] ? local.number_subnets : 0
  route_table_id         = element(aws_route_table.default.*.id, count.index)
  gateway_id             = element(var.gateway_ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.default]

}

resource "aws_route_table_association" "default" {
  count          = length(split(",", var.subnet_cidrs))
  subnet_id      = element(aws_subnet.default.*.id, count.index)
  route_table_id = element(aws_route_table.default.*.id, count.index)
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_network_acl" "public" {
  count = var.network_acl_id == "" ? 1 : 0

  vpc_id     = var.vpc_id
  subnet_ids = aws_subnet.default.*.id

  dynamic "egress" {
    for_each = var.network_acl_egress
    content {
      action          = lookup(egress.value, "action", null)
      cidr_block      = lookup(egress.value, "cidr_block", null)
      from_port       = lookup(egress.value, "from_port", null)
      icmp_code       = lookup(egress.value, "icmp_code", null)
      icmp_type       = lookup(egress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
      protocol        = lookup(egress.value, "protocol", null)
      rule_no         = lookup(egress.value, "rule_no", null)
      to_port         = lookup(egress.value, "to_port", null)
    }
  }
  dynamic "ingress" {
    for_each = var.network_acl_ingress
    content {
      action          = lookup(ingress.value, "action", null)
      cidr_block      = lookup(ingress.value, "cidr_block", null)
      from_port       = lookup(ingress.value, "from_port", null)
      icmp_code       = lookup(ingress.value, "icmp_code", null)
      icmp_type       = lookup(ingress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
      protocol        = lookup(ingress.value, "protocol", null)
      rule_no         = lookup(ingress.value, "rule_no", null)
      to_port         = lookup(ingress.value, "to_port", null)
    }
  }
  tags = merge(
    {
      "Name" = "${var.subnet_name}-ACLs"
    },
    var.subnet_tags,
  )
  depends_on = [aws_subnet.default]
}
