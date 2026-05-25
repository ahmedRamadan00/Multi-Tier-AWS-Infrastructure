output "vpc_id" {
  description = "The ID of the main VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_a_id" {
  description = "subnet a private ip"
  value       = aws_subnet.private_a.id
}

output "private_subnet_b_id" {
  description = "subnet b private ip"
  value       = aws_subnet.private_b.id
}

output "public_subnet_a_id" {
  description = "subnet a public ip"
  value       = aws_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "subnet b public ip"
  value       = aws_subnet.public_b.id
}

output "db_subnet_a_id" {
  description = "subnet a db ip"
  value       = aws_subnet.db_a.id
}

output "db_subnet_b_id" {
  description = "subnet a db ip"
  value       = aws_subnet.db_b.id
}