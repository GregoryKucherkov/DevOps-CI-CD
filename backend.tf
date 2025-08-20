# terraform {
#   backend "s3" {
#     bucket         = "name"                               # Nmae of S3-bucket, need to be typed in manually
#     key            = "lesson-5/terraform.tfstate"         
#     region         = "us-west-2"                        
#     dynamodb_table = "terraform-locks"                    # DynamoDB table name
#     encrypt        = true                                
#   }
# }