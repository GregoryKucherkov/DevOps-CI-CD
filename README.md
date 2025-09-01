# Project usage

This project deploys an s3, VPC(with subnets), EKS, ECR cluster using Terraform. You need an AWS account and configured credentials to use it.

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


## Step 2
In order to continue you suppose to have your docker image ready. You can check it with command: docker images 

next step is Authenticate Docker to ECR:

use:
aws ecr get-login-password --region <your-region> \
 | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com

 Once it is done, you need to upload your image to ecr.

First, Tag your local image for ECR:
docker tag <your-local-image>:<tag> <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/<your-ecr-repo>:<tag>


then, Push the image to ECR:
docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/<your-ecr-repo>:<tag>

p.s. if your image is arm(mac) and kuberenetes cluster works on amd64, use the following to rebuild your image:
docker buildx build --platform linux/amd64 -t <docner-image-name>.amazonaws.com/<ecr-repo-name>:<tag> . --push
make sure you are in directory where dockerfile of your image is!


Update kubectl credentials:
aws eks update-kubeconfig --name <cluster-name> --region <region>


create ecr-registry-secret:

kubectl create secret docker-registry ecr-registry-secret \
 --docker-server=<your-ecr-url> \
 --docker-username=AWS \
 --docker-password=$(aws ecr get-login-password --region <region>)


Create generic secret for Postgres password:
kubectl create secret generic django-app-postgres --from-literal=POSTGRES_PASSWORD='your password'

Finally:
helm upgrade --install django-app . \
  --set image.repository=<your-account-id>.dkr.ecr.<your-region>.amazonaws.com/<repository-name> \
  --set image.tag=latest

Notice: I am passing ecr repository, as I don't want to hardcode aws account name.

To port forward use:
kubectl port-forward pod/<pod-name> <local-port>:<pod-port>
