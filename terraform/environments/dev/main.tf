terraform {
  required_version = ">= 1.8.0" # Ensure that the Terraform version is 1.8.0 or higher

  backend "s3" {
    bucket         = "terraform-remote-state-bucket-339087216988-eu-north-1-an"  # S3 bucket for storing Terraform state
    key            = "user-service/dev/terraform.tfstate"   # Path within the bucket for the state file
    region         = "eu-north-1"                           # AWS region where the S3 bucket is located
    encrypt        = true                                   # Enable server-side encryption for the state file
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws" # Specify the source of the AWS provider
      version = "~> 5.0"        # Use a version of the AWS provider that is compatible with version
    }
  }
}

provider "aws" {
  region = "eu-north-1" # Set the AWS region to EU North (Stockholm)
}

# ==========================================
# 1. PREREQUISITES: IAM ROLES
# ==========================================

# EC2 Instance Profile (Allows Beanstalk EC2 instances to talk to AWS services like ECR, S3, Systems Manager)
resource "aws_iam_role" "eb_ec2_role" {
  name = "tf-elastic-beanstalk-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach standard AWS-managed policies for Beanstalk instances
resource "aws_iam_role_policy_attachment" "eb_web_tier" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "eb_multicontainer" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_role_policy_attachment" "eb_worker_tier" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

# Instance Profile container required by EC2
resource "aws_iam_instance_profile" "eb_ec2_profile" {
  name = "tf-elastic-beanstalk-ec2-profile"
  role = aws_iam_role.eb_ec2_role.name
}


# ==========================================
# 2. THE ELASTIC BEANSTALK APPLICATION
# ==========================================

resource "aws_elastic_beanstalk_application" "user_service_app" {
  name        = "tf-user-service-app"
  description = "User Service App Managed by Terraform"
}


# ==========================================
# 3. THE ELASTIC BEANSTALK ENVIRONMENT
# ==========================================

resource "aws_elastic_beanstalk_environment" "user_service_env" {
  name                = "tf-user-service-app-dev"
  application         = aws_elastic_beanstalk_application.user_service_app.name

  # Platform: Running Docker on AL2023 (Modern Amazon Linux 2023 stack)
  solution_stack_name = "64bit Amazon Linux 2023 v4.13.3 running Docker"

  # ----------------------------------------------------
  # Configuration Settings (Namespaced key-value pairs)
  # ----------------------------------------------------

  # Instance Profile Link (CRITICAL: Beanstalk instances won't launch without this)
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_ec2_profile.name
  }

  # Capacity & Autoscaling (Minimal setup for Dev, scale up for Prod)
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance" # Change to "LoadBalanced" for production scaling
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro" # Java/Kotlin apps need at least 2GB RAM to perform safely
  }

  # Spring Application Environment Variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SPRING_PROFILES_ACTIVE"
    value     = "dev"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SERVER_PORT"
    value     = "5000" # Elastic Beanstalk's default proxy (Nginx) expects port 5000
  }
}
