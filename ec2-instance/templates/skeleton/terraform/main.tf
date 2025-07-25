terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  #backend "s3" {
    # Configure your S3 backend here
    # bucket = "your-terraform-state-bucket"
    # key    = "ec2/${{ values.name }}/terraform.tfstate"
    # region = "${{ values.region }}"
  #}
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "${{ values.name }}"
      Environment = var.environment
      Owner       = "${{ values.owner }}"
      ManagedBy   = "terraform"
      CreatedBy   = "backstage"
    }
  }
}

# Data source for latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security Group
resource "aws_security_group" "instance_sg" {
  name_prefix = "${{ values.name }}-"
  description = "Security group for ${{ values.name }} EC2 instance"
  
  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this in production
  }
  
  # HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # HTTPS access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${{ values.name }}-security-group"
  }
}

# EC2 Instance
resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  {% if values.key_name %}key_name      = var.key_name{% endif %}
  
  security_groups = [aws_security_group.instance_sg.name]
  
  # Enable detailed monitoring
  monitoring = true
  
  # User data script for initial setup
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    instance_name = "${{ values.name }}"
    environment   = var.environment
  }))
  
  tags = {
    Name        = "${{ values.name }}"
    Environment = var.environment
  }
  
  # Prevent accidental termination in production
  disable_api_termination = var.environment == "prod" ? true : false
  
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    encrypted             = true
    delete_on_termination = true
    
    tags = {
      Name = "${{ values.name }}-root-volume"
    }
  }
}

# Elastic IP (optional, uncomment if needed)
# resource "aws_eip" "main" {
#   instance = aws_instance.main.id
#   domain   = "vpc"
#   
#   tags = {
#     Name = "${{ values.name }}-eip"
#   }
# }
