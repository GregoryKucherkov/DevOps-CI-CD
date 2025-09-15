output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# output "s3_bucket_name" {
#     description = "s3 bucket name for states"
#     value = module.s3_backend.s3_bucket_name
# }

# output "dynamodb_table_name" {
#     description = "DynamoDB locking table name"
#     value = module.s3_backend.dynamodb_table_name
# }

#-------------ECR-----------------

output "ecr_repo_url" {
    description = "Ecr repository URL"
    value = module.ecr.ecr_repo_url
}

#-------------EKS-----------------
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

output "oidc_provider_url" {
  description = "OIDC Provider URL"
  value       = module.eks.oidc_provider_url
}
#-------------Jenkins-----------------
output "jenkins_release" {
  description = "Jenkins release name"
  value       = module.jenkins.jenkins_release_name
}
output "jenkins_namespace" {
  description = "Jenkins namespace"
  value       = module.jenkins.jenkins_namespace
}
#-------------ArgoCD-----------------
output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = module.argo_cd.namespace
}
output "argocd_server_service" {
  description = "ArgoCD server service"
  value       = module.argo_cd.argo_cd_server_service
}
output "argocd_admin_password" {
  description = "Initial admin password"
  value       = module.argo_cd.admin_password
}

#-------------RDS-----------------

output "rds_endpoint" {
  description = "The endpoint of the RDS/Aurora database"
  value       = module.rds.endpoint
}

output "rds_port" {
  description = "The port of the RDS/Aurora database"
  value       = module.rds.port
}

output "rds_db_name" {
  description = "The initial database name"
  value       = module.rds.db_name
}

output "rds_id" {
  description = "The ID of the RDS instance."
  value       = module.rds.id
}

output "rds_arn" {
  description = "The ARN of the RDS instance."
  value       = module.rds.arn
}


output "db_master_username" {
  description = "Master DB username"
  value       = module.rds.username
}