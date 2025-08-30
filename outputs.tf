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

output "eks_cluster_name" {
  value = module.eks.cluster_name

}

output "kubectl_config_command" {
  description = "kubectl config command to configure local kubectl"
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}"
  
}


output "oidc_provider_arn" {
  description = "OIDC provider ARN for the EKS cluster, used for IRSA and service accounts"
  value = module.eks.oidc_provider_arn
}