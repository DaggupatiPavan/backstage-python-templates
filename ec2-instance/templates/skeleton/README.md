# ${{ values.name }}

${{ values.description }}

## Infrastructure Details

- **Instance Type**: ${{ values.instance_type }}
- **Region**: ${{ values.region }}
- **Environment**: ${{ values.environment }}
- **Owner**: ${{ values.owner }}

## Getting Started

This repository contains Terraform configuration for provisioning an AWS EC2 instance.

### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0 installed
- Access to the target AWS account

### Deployment

1. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```

2. Plan the deployment:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

### Accessing the Instance

{% if values.key_name %}
SSH access is available using the key pair: `${{ values.key_name }}`

```bash
ssh -i ~/.ssh/${{ values.key_name }}.pem ec2-user@<instance-public-ip>
```
{% endif %}

## Configuration

The instance is configured with the following specifications:

| Parameter | Value |
|-----------|-------|
| Instance Type | ${{ values.instance_type }} |
| Region | ${{ values.region }} |
| Environment | ${{ values.environment }} |
{% if values.key_name %}| SSH Key | ${{ values.key_name }} |{% endif %}

## Monitoring and Maintenance

- CloudWatch monitoring is enabled by default
- Automatic security updates are configured
- Instance is tagged for cost tracking

## Support

For support or questions, please contact: ${{ values.owner }}