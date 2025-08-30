# Project usage

This project deploys a VPC and an EKS cluster using Terraform. You need an AWS account and configured credentials to use it.

1. Clone the repository:
   git clone <repo-url>
   cd <repo-directory>

2. Initialize Terraform:
   terraform init

3. Preview the infrastructure plan:
   terraform plan

4. Apply the configuration:
   terraform apply

## Backend

The remote backend is initially commented. After the first terraform apply:
Uncomment the backend block in root.
Run:
terraform init
terrform apply

Now you have terraform state in remotely stored in s3 bucket.

