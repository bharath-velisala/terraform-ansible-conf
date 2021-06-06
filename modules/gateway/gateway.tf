resource "aws_internet_gateway" "gw" {
    vpc_id = "${var.vpc_id}"
  
}

output "gateway_id" {
    value = "${aws_internet_gateway.gw.id}"
  
}

output "gateway" {
    value = "${aws_internet_gateway.gw}"
  
}