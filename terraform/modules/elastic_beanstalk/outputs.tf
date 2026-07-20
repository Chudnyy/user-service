# ==========================================
# MODULE OUTPUTS
# ==========================================

output "application_name" {
  description = "The name of the Elastic Beanstalk application"
  value       = aws_elastic_beanstalk_application.user_service_app.name
}

output "environment_name" {
  description = "The name of the Elastic Beanstalk environment"
  value       = aws_elastic_beanstalk_environment.user_service_env.name
}

output "environment_port" {
  description = "The port on which the application is running"
  value       = var.server_port
}

output "environment_endpoint" {
  description = "The endpoint URL of the Elastic Beanstalk environment"
  value       = aws_elastic_beanstalk_environment.user_service_env.endpoint_url
}
