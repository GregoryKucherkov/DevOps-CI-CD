# Project description

To start a project use:
terraform init

Next command will show you, what terraform is going to buid:
terraform plan

To actually create you infrustructure use:
terraform apply

If you want to destroy infrastructure you built, use:
terraform destroy

## Details

This project creates the following structure:

S3 bucket for state + DynamoDB for locks, VPC, and ECR for storing container images.

It generates outputs for the resources created by the project.

Modules

s3-backend/ – Module for Terraform state management

Creates an S3 bucket for storing Terraform state.

Creates a DynamoDB table for state locking.

vpc/ – Module for networking

Creates a Virtual Private Cloud (VPC) with 3 public subnets having Internet access via an Internet Gateway.

Creates 3 private subnets with Internet access through a NAT Gateway.

Manages routing using route tables.

ecr/ – Module for container registry

Creates an ECR repository with automatic image scanning.

The code utilizes variables to support future scalability.
