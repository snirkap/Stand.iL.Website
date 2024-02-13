terraform {
  backend "s3" {
    bucket = "stand-web-tf-state-backup"
    key    = "backup/terraform.tfstate"
    region = "us-east-1"
  }
}
