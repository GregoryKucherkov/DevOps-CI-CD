provider "aws" {
    region = var.aws_region

    default_tags {
        tags = var.tags
  }
}


resource "random_id" "suffix" {
  byte_length = 4
}



module "s3_backend" {
    source      = "./modules/s3-backend"
    bucket_name = "terraform-state-bucket-${random_id.suffix.hex}"
    table_name  = "terraform-locks"
}


# Call VPC
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = var.vpc_cidr_block 
  public_subnets     = var.public_subnets_cidrs
  private_subnets    = var.private_subnets_cidrs
  availability_zones = var.availability_zones
  vpc_name           = "lesson-7-vpc"
}


# Call ecr
module "ecr" {
    source          = "./modules/ecr"
    ecr_name        = "lesson-7-ecr"
    force_delete    = true
}


# Call EKS module
module "eks" {
  source                     = "./modules/eks"
  cluster_name               = "hw_7_eks"
  cluster_version            = "1.31"

  vpc_id                     = module.vpc.vpc_id
  public_subnets             = module.vpc.public_subnets
  private_subnets            = module.vpc.private_subnets
  ebs_csi_driver_irsa_arn    = module.ebs_csi_driver_irsa.iam_role_arn

  tags                       = var.tags
}

data "aws_eks_cluster" "hw7" {
  name = "hw_7_eks"
}

data "aws_iam_openid_connect_provider" "hw7" {
  url = data.aws_eks_cluster.hw7.identity[0].oidc[0].issuer
}



module "ebs_csi_driver_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name_prefix = "AmazonEKS_EBS_CSI_Driver"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      # provider_arn               = module.eks.oidc_provider_arn
      provider_arn               = data.aws_iam_openid_connect_provider.hw7.arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
      
    }
  }
 
}


