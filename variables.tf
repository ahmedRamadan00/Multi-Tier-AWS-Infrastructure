variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "VPC_cidr_block" {
  type = string
}

variable "public_subnet_a" {
  type = string
}

variable "public_subnet_b" {
  type = string
}

variable "private_subnet_a" {
  type = string
}

variable "private_subnet_b" {
  type = string
}

variable "db_subnet_a" {
  type = string
}

variable "db_subnet_b" {
  type = string
}

variable "instance_type" {
  type = string
}