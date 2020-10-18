
module "my-table" {
  source = "../..//AWSModules/dynamodb"
  name      = var.name
  hash_key  = var.hash_key
  range_key = var.range_key
  attributes = var.attributes 
  global_secondary_indexes = var.global_secondary_indexes
  tags = var.tags
  point_in_time_recovery_enabled=var.point_in_time_recovery_enabled 
}


