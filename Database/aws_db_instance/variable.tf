variable "sg_db_rds_id" {
  type = string
}
variable "db_subnet_group_name" {
  type = string
}
variable "db_name" {
  type    = string
  default = "task_manager"
  description = "The name of the initial database"
}

variable "username" {
  type    = string
  description = "The database username"
}

variable "password" {
  type = string
  sensitive = true
  description = "The database password"
}