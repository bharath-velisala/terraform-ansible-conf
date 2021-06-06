resource "null_resource" "execute-ansible"{
    provisioner "local-exec" {
        command = "${var.command}"
        //command = "ansible-playbook -i ansible/playbooks/project1/inventory.ini  ansible/playbooks/project1/master.yml"
    }
}