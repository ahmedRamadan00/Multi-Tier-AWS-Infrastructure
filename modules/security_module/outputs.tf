output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "ec2_role_arn" {
  value = aws_iam_role.ec2_role.arn
}

output "kms_rds_arn" {
  value = aws_kms_key.rds.arn
}

output "kms_s3_arn" {
  value = aws_kms_key.s3.arn
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db.arn
}