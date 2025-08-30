module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 20.0"

    
    cluster_name    = var.cluster_name
    cluster_version = var.cluster_version

    vpc_id   = var.vpc_id
    subnet_ids = var.public_subnets
    control_plane_subnet_ids = var.private_subnets

    cluster_endpoint_public_access           = true
    enable_cluster_creator_admin_permissions = true

    enable_irsa = true

    #   cluster add-ons
    cluster_addons = {
        coredns = {
            most_recent = true
            resolve_conflict = "OVERWRITE"
        }
        kube-proxy = {
            most_recent = true
            resolve_conflict = "OVERWRITE"
        }
        vpc-cni    = {
            most_recent = true
            resolve_conflict = "OVERWRITE"
        }
        # need IAM role
        aws-ebs-csi-driver = {
            most_recent = true
            resolve_conflict = "OVERWRITE"
            preserve_on_delete = false
            service_account_role_arn = var.ebs_csi_driver_irsa_arn
            # pod_identity_association = [{
            #     service_account = "ebs-csi-controller-sa"
            #     namespace = "kube-system"
            #     role_arn = var.ebs_csi_driver_irsa_arn 
            # }] 
        }

    }

    eks_managed_node_group_defaults = {
            ami_type       = "AL2023_x86_64_STANDARD"
            min_size       = 1
            max_size       = 6
            desired_size   = 2
    }

    eks_managed_node_groups = {
        cpu_group_1 = {
        instance_types = ["t3.medium"]
        tags = var.tags
        }

    }

}