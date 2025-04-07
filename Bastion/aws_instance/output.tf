 output "private_ip" {
   value = aws_instance.bastion-master.private_ip
 }
 output "id" {
  value = aws_instance.bastion-master.id
}

output "tags" {
  value = aws_instance.bastion-master.tags
}
output "public_ip" {
  value = aws_instance.bastion-master.public_ip
}
