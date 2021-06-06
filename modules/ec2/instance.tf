resource "aws_instance" "ec2_instance" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  network_interface {
    device_index = 0
    network_interface_id = "${var.interface_id}"
  
  }
  tags = {
    Name = "web-server"
  }

}

resource "local_file" "inventory"{
    content = "${aws_instance.ec2_instance.public_ip}"
    filename = "/home/azureuser/terraform/terraform-ansible-conf/ansible/playbooks/project1/inventory.ini"
}


