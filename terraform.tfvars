tags = {
  Environment = "dev"
  Project     = "goit-lesson-9"
  ManagedBy   = "terraform"
}

aws_region = "us-east-1"

vpc_name = "my-vpc"

vpc_cidr_block = "10.0.0.0/16"

availability_zones = ["us-east-1a", "us-east-1b"]

public_subnets_cidrs = ["10.0.1.0/24","10.0.2.0/24"]

private_subnets_cidrs = ["10.0.11.0/24","10.0.12.0/24"]

cluster_name = "hw_9_eks" 