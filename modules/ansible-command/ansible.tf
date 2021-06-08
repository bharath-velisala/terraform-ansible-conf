resource "null_resource" "execute-ansible"{

    triggers = {
    cluster_instance_ids = join( aws_instance.c.*.id)
  }
    provisioner "local-exec" {
        command = "${var.command}"
        //command = "ansible-playbook -i ansible/playbooks/project1/inventory.ini  ansible/playbooks/project1/master.yml"
    }
}