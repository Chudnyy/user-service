terraform {
  required_version = ">= 1.15.0"

  backend "s3" {
    bucket = "terraform-remote-state-bucket-339087216988-eu-north-1-an"
    key    = "user-service/dev/terraform.tfstate"
    region = "eu-north-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ==========================================
# DEV ENVIRONMENT - CALLS MODULE
# ==========================================

module "elastic_beanstalk_dev" {
  source = "../../modules/elastic_beanstalk"

  environment_type = "dev"
  application_name = "user-service"
  instance_type    = "t3.nano"
  server_port      = var.server_port
  spring_profile   = "dev"
}

