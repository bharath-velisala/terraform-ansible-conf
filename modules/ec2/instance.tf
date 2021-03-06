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

resource "null_resource" "previous" {

  triggers = {
    cluster_instance_ids = "${aws_instance.ec2_instance.public_ip}"
    
    }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "10s"
}

resource "null_resource" "execute-ansible"{
    depends_on = [time_sleep.wait_30_seconds]
    provisioner "local-exec" {
        command = "sudo ansible-playbook -i /home/azureuser/terraform/terraform-ansible-conf/ansible/playbooks/project1/inventory.ini  /home/azureuser/terraform/terraform-ansible/ansible/playbooks/project1/master.yml -u ubuntu  --private-key ~/.ssh/aws-keypair.pem"
        //command = "ansible-playbook -i ansible/playbooks/project1/inventory.ini  ansible/playbooks/project1/master.yml"
    }
}

