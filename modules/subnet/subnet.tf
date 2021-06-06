resource "aws_subnet" "subnet-1" {
    vpc_id = "${var.vpc_id}"
    cidr_block = "${var.cidr_block}"
    map_public_ip_on_launch = true
    tags={
        Name = "subnet"
    } 
}

output "subnet_id" {
    value = "${aws_subnet.subnet-1.id}"
  
}