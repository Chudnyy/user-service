# ==========================================
# ELASTIC BEANSTALK ENVIRONMENT
# ==========================================

resource "aws_elastic_beanstalk_environment" "user_service_env" {
  name        = "tf-${var.application_name}-app-${var.environment_type}"
  application = aws_elastic_beanstalk_application.user_service_app.name

  solution_stack_name = "64bit Amazon Linux 2023 v4.13.3 running Docker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_ec2_profile.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SPRING_PROFILES_ACTIVE"
    value     = var.spring_profile
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SERVER_PORT"
    value     = tostring(var.server_port)
  }
}
