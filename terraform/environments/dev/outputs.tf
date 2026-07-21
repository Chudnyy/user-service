# ==========================================
# DEV OUTPUTS - FROM MODULE
# ==========================================

output "application_name" {
  description = "The name of the Elastic Beanstalk application"
  value       = module.elastic_beanstalk_dev.application_name
}

output "environment_name" {
  description = "The name of the Elastic Beanstalk environment"
  value       = module.elastic_beanstalk_dev.environment_name
}

output "environment_port" {
  description = "The port on which the application is running"
  value       = module.elastic_beanstalk_dev.environment_port
}

output "environment_endpoint" {
  description = "The endpoint URL of the Elastic Beanstalk environment"
  value       = module.elastic_beanstalk_dev.environment_endpoint
}

