terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
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



# EC2 Instance
resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  {% if values.key_name %}key_name      = var.key_name{% endif %}
  
  vpc_security_group_ids = ["sg-0d56e86ef61a7dc01"]
  subnet_id = "subnet-02cf2e19298b8cdac"
  
  # User data script for initial setup
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    instance_name = "${{ values.name }}"
    environment   = var.environment
  }))
  
  tags = {
    Name        = "marvel-RHDH-${{ values.name }}"
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
      Name = "marvel-RHDH-${{ values.name }}-root-volume"
    }
  }
}

