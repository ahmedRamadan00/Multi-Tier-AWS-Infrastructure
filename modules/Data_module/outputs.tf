output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS instance (host:port)"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_address" {
  description = "The address of the RDS instance (Host name)"
  value       = aws_db_instance.main.address
}

output "db_instance_id" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.main.id
}