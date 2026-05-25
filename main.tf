module "network_module" {
  source = "./modules/network_module"

  VPC_cidr_block   = var.VPC_cidr_block
  public_subnet_a  = var.public_subnet_a
  public_subnet_b  = var.public_subnet_b
  private_subnet_a = var.private_subnet_a
  private_subnet_b = var.private_subnet_b
  db_subnet_a      = var.db_subnet_a
  db_subnet_b      = var.db_subnet_b
}

module "security_module" {
  source = "./modules/security_module"

  vpc_id = module.network_module.vpc_id
}

module "compute_module" {
  source = "./modules/compute_module"

  vpc_id             = module.network_module.vpc_id
  alb_sg_id          = module.security_module.alb_sg_id
  ec2_sg_id          = module.security_module.ec2_sg_id
  public_subnet_ids  = [module.network_module.public_subnet_a_id, module.network_module.public_subnet_b_id]
  private_subnet_ids = [module.network_module.private_subnet_a_id, module.network_module.private_subnet_b_id]
  instance_type      = var.instance_type
}

module "data_module" {
  source = "./modules/Data_module"

  db_subnet_a_id = module.network_module.db_subnet_a_id
  db_subnet_b_id = module.network_module.db_subnet_b_id
  rds_sg_id      = module.security_module.rds_sg_id
  kms_rds_arn    = module.security_module.kms_rds_arn
}

module "storage_module" {
  source = "./modules/storage_module"

  kms_s3_arn = module.security_module.kms_s3_arn
}