resource "aws_vpc" "prod-vpc" {
    cidr_block = "${var.vpc_cidr}"
    tags = {
      Name = "production"
    }
    
  
}

output "vpc_id" {
      value = "${aws_vpc.prod-vpc.id}"
}