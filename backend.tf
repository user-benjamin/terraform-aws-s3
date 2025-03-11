# Configure the Terraform backend to use an S3 bucket for remote state storage.
# Replace 'my-terraform-state-bucket' and 'repo-name/env' with your actual values.

# terraform {
#   backend "s3" {
#     bucket         = "mainstatebucket"
#     key            = "repo-name/env/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-lock-table"
#   }
# }
