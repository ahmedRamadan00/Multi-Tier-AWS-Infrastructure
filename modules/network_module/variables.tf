variable "AZ" {
  type = string
  default = "us-east-1"
}

variable "VPC_cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_a" {
    type = string
    default = "10.0.1.0/24"
}

variable "public_subnet_b" {
    type = string
    default = "10.0.2.0/24"
}

variable "private_subnet_a" {
    type = string
    default = "10.0.11.0/24"
}

variable "private_subnet_b" {
    type = string
    default = "10.0.12.0/24"
}

variable "db_subnet_a" {
    type = string
    default = "10.0.21.0/24"
}

variable "db_subnet_b" {
    type = string
    default = "10.0.22.0/24"
}