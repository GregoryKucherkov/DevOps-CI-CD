variable "tags" {
    description = "A map of tags to assign to the resources."
    type = map(string)
    
}

variable "aws_region" {
    description = "Default Region"
    type = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for state locking."
  type        = string
}


# VPC
variable "vpc_name" {
    description = "Name of VPC"
    type    = string
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type    = string
}

variable "availability_zones" {
    description = "List of availability zones in the region"
    type    = list(string)
}

variable "public_subnets_cidrs" {
    description = "List of public subnet CIDR blocks"
    type    = list(string)
}

variable "private_subnets_cidrs" {
    description = "List of private subnet CIDR blocks"
    type    = list(string)
}

# ECR block 
variable "ecr_name" {
  type = string
}

variable "force_delete" {
  type = bool
  
}


# EKS module
variable "cluster_name" {
  type = string
  
}

variable "eks_cluster_version" {
  type = string
  
}

# ARGO_CD module
variable "argo_namespace" {
  type = string
  
}
variable "argo_chart_version" {
  type = string
  
}


#  github credentials
variable "github_pat" {
  description = "GitHub Personal Access Token"
  type        = string
}
variable "github_user" {
  description = "GitHub username"
  type        = string
}
variable "github_repo_url" {
  description = "GitHub repository name"
  type        = string
}

# RDS module

variable "rds_name" {
  type = string
  
}

variable "use_aurora" {
  type = bool
  
}