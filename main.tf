provider "aws" {
    region = "us-east-1"
  
}

module "vpc" {
    source = "/home/azureuser/terraform/terraform-ansible-conf/modules/vpc"
    vpc_cidr = "10.0.0.0/16"
}

module "gateway" {
    source = "/home/azureuser/terraform/terraform-ansible-conf/modules/gateway"
    vpc_id = "${module.vpc.vpc_id}"
  
}

module "route-table" {
    source = "/home/azureuser/terraform/terraform-ansible-conf/modules/route-table"
    vpc_id = "${module.vpc.vpc_id}"
    cidr_block = "0.0.0.0/0"
    gateway_id = "${module.gateway.gateway_id}"
  
}

module "subnet" {
    source = "/home/azureuser/terraform/terraform-ansible-conf/modules/subnet"
     vpc_id = "${module.vpc.vpc_id}"
     cidr_block = "10.0.1.0/24"

}

module "associate-route-table" {
    source = "/home/azureuser/terraform/terraform-ansible-conf/modules/assocaite-route"
    subnet_id = "${module.subnet.subnet_id}"
    route_table_id = "${module.route-table.route_table_id}"
  
}

module "security-group" {
    source = "/home/azureuser/terraform/terraform-ansible-conf/modules/security-group"
    name = "allow web traffic"
    description = "allow tls inbound traffic"
     vpc_id = "${module.vpc.vpc_id}"
  
}

module "network-interface" {
    source = "/home/azureuser/terraform/terraform-ansible-conf/modules/network-interface"
    subnet_id = "${module.subnet.subnet_id}"
    private_ip = "10.0.1.50"
    security_group = "${module.security-group.security_group_id}"
}

# module "eip" {
#      source = "./modules/elastic-ip"
#     network_interface_id = "${module.network-interface.nic_id}"
#     private_ip = "10.0.1.50"
#     gateway = "${module.gateway.gateway}"
  
  
# }

module "ec2" {
     source = "/home/azureuser/terraform/terraform-ansible-conf/modules/ec2"
    ami_id = "ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
    key_name = "aws-keypair"
    interface_id = "${module.network-interface.nic_id}"
  
}

module "ansible"{
    source="/home/azureuser/terraform/terraform-ansible-conf/modules/ansible-command"
    command ="sudo ansible-playbook -i /home/azureuser/terraform/terraform-ansible-conf/ansible/playbooks/project1/inventory.ini  /home/azureuser/terraform/terraform-ansible/ansible/playbooks/project1/master.yml -u ubuntu --private-key ~/.ssh/aws-keypair.pem"
}