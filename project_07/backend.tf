terraform {
  backend "s3" {
    bucket = "s3-terraform-backend-files-hyderabad"
    key    = "project_07/terraform.tfstate"
    region = "ap-south-2"
  }
}
