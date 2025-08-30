output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster"
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint for your EKS Kubernetes API."
}


output "cluster_arn" {
  value       = module.eks.cluster_arn
  description = "The Amazon Resource Name (ARN) of the cluster"
}

# output "oidc_provider_arn" {
#   value = aws_eks_cluster.this[0].identity[0].oidc[0].issuer
# }

output "oidc_provider_arn" {
  description = "OIDC provider ARN for the EKS cluster"
  value       = module.eks.cluster_oidc_issuer_url
}

# Forward the cluster security group IDs
output "cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = module.eks.cluster_security_group_id
}