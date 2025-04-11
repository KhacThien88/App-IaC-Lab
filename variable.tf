variable "profile" {
  type    = string
  default = "default"
}
variable "region-master" {
  type    = string
  default = "ap-southeast-1"
}
variable "cidr_block_master_vpc" {
  type    = string
  default = "10.0.0.0/16"
}
variable "cidr_block_public_subnet_1" {
  type    = string
  default = "10.0.0.0/24"
}
variable "cidr_block_public_subnet_2" {
  type    = string
  default = "10.0.1.0/24"
}
variable "cidr_block_private_subnet_1" {
  type    = string
  default = "10.0.2.0/24"
}
variable "cidr_block_private_subnet_2" {
  type    = string
  default = "10.0.3.0/24"
}
variable "cidr_block_private_subnet_3" {
  type    = string
  default = "10.0.4.0/24"
}
variable "cidr_block_private_subnet_4" {
  type    = string
  default = "10.0.5.0/24"
}
variable "db_password" {
  default   = "MySecurePassw0rd123!"
  type      = string
  sensitive = true
}
variable "ami_id" {
  default = "ami-065a492fef70f84b1"
  type    = string
}
variable "instance_type" {
  default = "t2.small"
  type    = string
}
variable "db_name" {
  default   = "task_manager"
  type      = string
  sensitive = true
}
variable "target_scale_down" {
  type    = number
  default = 30
}
variable "target_scale_up" {
  type    = number
  default = 70
}
variable "site-name" {
  type    = string
  default = "todoapp-backend"
}
variable "dns-name" {
  type    = string
  default = "khacthienit.click."
}
variable "db_username" {
  type      = string
  default   = "admin"
  sensitive = true
}
variable "name_secret" {
  type      = string
  sensitive = true
  default   = "secret_db_mysql"
}
variable "path_to_file_key" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
variable "instance-type-master" {
  type    = string
  default = "t2.micro"
}
variable "credential_login_secret_arn" {
  type = string
  default = "arn:aws:secretsmanager:ap-southeast-1:160885258086:secret:credential-login-qKROtS"
}