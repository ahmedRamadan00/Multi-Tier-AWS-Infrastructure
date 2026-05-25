variable "lb_target_group_port" {
  default = 8080
}

variable "lb_target_group_protocol" {
  default = "HTTP"
}

variable "lb_listener_port" {
  default = 80
}

variable "lb_listener_protocol" {
  default = "HTTP"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "policy_type" {
  default = "SimpleScaling"
}

variable "adjustment_type" {
  default = "ChangeInCapacity"
}

# modules/compute/variables.tf

variable "vpc_id" {
  type        = string
  description = "VPC ID from networking module"
}

variable "alb_sg_id" {
  type        = string
  description = "ALB Security Group ID from security module"
}

variable "ec2_sg_id" {
  type        = string
  description = "EC2 Security Group ID from security module"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the ALB"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the ASG"
}