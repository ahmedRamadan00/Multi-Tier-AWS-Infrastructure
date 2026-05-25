resource "aws_db_subnet_group" "main" {
  name        = "db-subnet-group-prod"
  description = "Database subnet group for private AZs deployment"
  subnet_ids  = [
    var.db_subnet_a_id,
    var.db_subnet_b_id
  ]

  tags = {
    Name = "db-subnet-group-prod"
  }
}

resource "aws_db_instance" "main" {
  identifier = "rds-prod"
  
  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage     = 100
  max_allocated_storage = 500
  storage_type          = "gp3"

  storage_encrypted = true
  kms_key_id        = var.kms_rds_arn

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]

  backup_retention_period   = 7
  deletion_protection       = false
  skip_final_snapshot       = false
  final_snapshot_identifier = "final-snapshot-prod"

  tags = {
    Name = "techops-rds-prod"
  }
}