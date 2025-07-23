variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "${{ values.region }}"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "${{ values.instance_type }}"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "${{ values.environment }}"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

{% if values.key_name %}
variable "key_name" {
  description = "AWS key pair name for SSH access"
  type        = string
  default     = "${{ values.key_name }}"
}
{% endif %}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Restrict this in production
}