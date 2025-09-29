# Project usage
This project deploys an s3, VPC(with subnets), EKS, ECR cluster using Terraform. You need an AWS account and configured credentials to use it.


1. Clone the repository:
   git clone <repo-url>
   cd <repo-directory>

!notice:
Create file terraform.tfvars in root, you need to porvide values for variables, such as:
aws_region
dynamodb_table_name
vpc_name
vpc_cidr_block 
availability_zones
public_subnets_cidrs
private_subnets_cidrs
ecr_name
force_delete
cluster_name
eks_cluster_version
argo_namespace
argo_chart_version
rds_name
use_aurora


2. Initialize Terraform:
   terraform init

3. Preview the infrastructure plan:
   terraform plan

In order to do so, you will need to provide GithUB ACCESS TOKEN, repository url and repository name.

4. Apply the configuration:
   terraform apply

## Backend

The remote backend is initially commented. After the first terraform apply:
Uncomment the backend block in root.
Run:
terraform init

Now you have terraform state in remotely stored in s3 bucket.

!notice make sure in terraform output you have oidc_provider_arn
if not, try creating Infrastructure by steps(first module eks, then else)


# Step 2

Update kubectl credentials:
aws eks update-kubeconfig --name <cluster-name> --region <region>


To list all namespaces:
kubectl get ns

To lists all services in the namespace you specify:
kubectl get svc -n <your-namecpace>

For example to get url for argocd(as it is on loadbalancer, and accessible by a link) you go:
kubectl get svc -n argocd

Login for argocd is:
admin

to get password for argocd:
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

Same for Jenkins, except it credentials in jenkins/values.yaml


## Jenkins:
 first got to UI, then approve seed job;
 kubectl get svc -n jenkins 

 you will see url(as it is on loadbalancer)
 
 To do so, go to manage Jenkins, scroll down to Script Approval, and aprrove it
 then build now -> it will create goit-django-docker 
 click Build now for goit-django-docker 


**Deploy applications via GitOps:**
    To deploy or update applications like `django-app`, modify the Helm chart files in `charts/django-app/` and push your changes to the Git repository. Argo CD will automatically sync and deploy them to the cluster.
  Use:
    git add .
    git commit -m "Deploying/Updating Django app"
    git push


**NOTICE**
For a moment of startting, there is no ecr ready, and Jenkins job hasn't been done, so after terraform finishes:
1. run Jenkins job(instructions on the above)
2. edit charts/django-app/values.yaml/image:repository: "aws_ecr" with image
3. push updated code to repo


Monitoring:
to see all services use:
kubectl get svc -n monitoring

As monitoring here is using ClusterIp to get access you need to port-forward

For Grafana user: admin
pass:
kubectl get secret kube-prometheus-stack-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

Port-forward:
kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80

For prometheus use:
kubectl port-forward svc/kube-prometheus-stack-prometheus -n monitoring 9090:9090
go to -> http://localhost:9090



