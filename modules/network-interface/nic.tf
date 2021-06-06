resource "aws_network_interface" "web-server-nic" {
  subnet_id       = "${var.subnet_id}"
  private_ips     = ["${var.private_ip}"]
  security_groups = ["${var.security_group}"]
}

output "nic_id" {
  value = "${aws_network_interface.web-server-nic.id}"
  
}