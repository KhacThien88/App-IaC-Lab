resource "aws_instance" "bastion-master" {
  ami                         = var.ami
  instance_type               = var.instance-type
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  subnet_id                   = var.subnet_id_1
  root_block_device {
    volume_size           = 30
    volume_type           = "gp2"
    delete_on_termination = true
  }
  provisioner "local-exec" {
    command = <<EOF
aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region} --instance-ids ${self.id} 
ansible-playbook --extra-vars 'passed_in_hosts=tag_Name_bastion-master' ${var.ansible_playbook_path}
EOF
  }
  tags = {
    Name = var.tag
  }
}
