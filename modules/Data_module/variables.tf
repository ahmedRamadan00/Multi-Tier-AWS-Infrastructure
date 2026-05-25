variable "db_subnet_a_id" {
  type = string
}

variable "db_subnet_b_id" {
  type = string
}

variable "rds_sg_id" {
  type = string
}

variable "kms_rds_arn" {
  type = string
}

variable "db_engine" {
  type = string
  default = "postgres"
}

variable "db_engine_version" {
  type    = string
  default = "16.3"
}

variable "db_instance_class" {
  type = string
  default = "db.t3.medium"
}

variable "db_name" {
  type = string
  default = "myappdb"
  sensitive = true
}

variable "db_username" {
  type      = string
  default   = "dbadmin"
  sensitive = true
}

variable "db_password" {
  type = string
  default = "admin123"
  sensitive = true
}



