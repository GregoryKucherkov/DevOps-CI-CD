terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-73fd2b50"                               # Name of S3-bucket, need to be typed in manually
    key            = "lesson-7/terraform.tfstate"         
    region         = "us-east-1"                        
    encrypt        = true                                
  }
} 