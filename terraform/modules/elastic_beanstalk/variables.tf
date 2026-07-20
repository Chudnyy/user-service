# ==========================================
# MODULE VARIABLES
# ==========================================

variable "environment_type" {
  description = "Environment type (dev, prod, etc)"
  type        = string
}

variable "application_name" {
  description = "Application name"
  type        = string
  default     = "user-service"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.nano"
}

variable "server_port" {
  description = "The port on which the application runs"
  type        = number
  default     = 5000
}

variable "spring_profile" {
  description = "Spring profile to activate"
  type        = string
  default     = "dev"
}
