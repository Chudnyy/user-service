# ==========================================
# ELASTIC BEANSTALK APPLICATION
# ==========================================

resource "aws_elastic_beanstalk_application" "user_service_app" {
  name        = "tf-${var.application_name}-app"
  description = "User Service App Managed by Terraform"
}
