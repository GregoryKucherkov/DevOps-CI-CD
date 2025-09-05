terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-2bf6c489"                               # Name of S3-bucket, need to be typed in manually
    key            = "lesson-9/terraform.tfstate"         
    region         = "us-east-1"                        
    encrypt        = true                                
  }
} 