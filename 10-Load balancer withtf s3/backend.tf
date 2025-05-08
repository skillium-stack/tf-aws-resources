terraform {
  backend "s3" {
    bucket         = "your-tfstate-bucket"
    key            = "path/to/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"     # Optional, but recommended for locking
    encrypt        = true                  # Encrypt state at rest
  }
}
