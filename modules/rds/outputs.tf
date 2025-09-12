output "endpoint" {
  description = "RDS endpoint for connecting to the database"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].endpoint : aws_db_instance.standard[0].endpoint
}

output "port" {
  description = "Database port"
  value = var.use_aurora ? aws_rds_cluster.aurora[0].port : aws_db_instance.standard[0].port
}

output "db_name" {
  description = "Database name"
  value       = var.db_name
}

output "username" {
  description = "Master DB username"
  value       = var.username
}

output "arn" {
  description = "ARN of the DB cluster or instance"
  value = var.use_aurora ? aws_rds_cluster.aurora[0].arn : aws_db_instance.standard[0].arn
}

output "id" {
  description = "ID of the DB cluster or instance"
  value = var.use_aurora ? aws_rds_cluster.aurora[0].id : aws_db_instance.standard[0].id
}