output "s3_bucket_name" {
    description = "s3 bucket name for states"
    value = module.s3_backend.s3_bucket_name
  
}

output "dynamodb_table_name" {
    description = "DynamoDB locking table name"
    value = module.s3_backend.dynamodb_table_name
  
}

output "ecr_repo_url" {
    description = "Ecr repository URL"
    value = module.ecr.ecr_repo_url
  
}