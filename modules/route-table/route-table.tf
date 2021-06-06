resource "aws_route_table" "prod-route-table" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "${var.cidr_block}"
    gateway_id = "${var.gateway_id}"
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = "${var.gateway_id}"
  }

  tags = {
    Name = "prod"
  }
}

output "route_table_id" {
  value = "${aws_route_table.prod-route-table.id}"
  
}