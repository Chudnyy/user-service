# ==========================================
# ENVIRONMENT VARIABLES
# ==========================================

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "server_port" {
  description = "The port the server will run on"
  type        = number
  default     = 5000
}