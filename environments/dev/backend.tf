terraform {

  backend "s3" {

    bucket         = "tfstatefiledemowinfo"
    key            = "devops-platform/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"

    encrypt = true
  }
}