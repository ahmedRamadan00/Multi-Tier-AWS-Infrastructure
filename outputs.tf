output "root_vpc_id" {
  value = module.network_module.vpc_id
}

output "root_alb_dns_name" {
  value = module.compute_module.alb_dns_name
}

output "root_database_endpoint" {
  value = module.data_module.db_instance_endpoint
}

output "root_assets_bucket_name" {
  value = module.storage_module.assets_bucket_name
}