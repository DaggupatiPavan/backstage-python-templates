# ${{ values.name }}

## Overview

${{ values.description }}

This documentation covers the infrastructure setup and management of the EC2 instance provisioned through Backstage.

## Architecture

The infrastructure consists of:

- **EC2 Instance**: ${{ values.instance_type }} running Amazon Linux 2
- **Security Group**: Configured with standard web and SSH access
- **IAM Role**: (Optional) For AWS service access
- **CloudWatch**: Monitoring and logging enabled

## Configuration

### Instance Specifications

| Property | Value |
|----------|-------|
| Instance Type | ${{ values.instance_type }} |
| Operating System | Amazon Linux 2 |
| Region | ${{ values.region }} |
| Environment | ${{ values.environment }} |
{% if values.key_name %}| SSH Key Pair | ${{ values.key_name }} |{% endif %}

### Security Configuration

The security group allows:
- SSH access on port 22
- HTTP access on port 80
- HTTPS access on port 443
- All outbound traffic

> **Note**: In production environments, restrict SSH access to specific IP ranges.

## Deployment

The infrastructure is deployed using Terraform with the following workflow:

1. **Plan**: Review changes before applying
2. **Apply**: Deploy infrastructure to AWS
3. **Verify**: Ensure instance is running and accessible

### Manual Deployment

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Automated Deployment

GitHub Actions workflow automatically:
- Validates Terraform configuration
- Plans changes on pull requests
- Applies changes on main branch merges

## Monitoring

### CloudWatch Metrics

Standard EC2 metrics are collected:
- CPU utilization
- Network in/out
- Disk read/write operations
- Status checks

### Logs

Application logs are stored in:
- `/var/log/custom/` - Custom application logs
- CloudWatch Logs (if configured)

## Maintenance

### Regular Tasks

- **Security Updates**: Automatic security updates are enabled
- **Monitoring**: Review CloudWatch metrics weekly
- **Backups**: Consider EBS snapshots for data persistence

### Scaling

To scale the instance:
1. Update `instance_type` in `terraform.tfvars`
2. Run `terraform plan` and `terraform apply`
3. Instance will be stopped and restarted with new size

## Troubleshooting

### Common Issues

**Instance not accessible via SSH**
- Verify security group allows SSH (port 22)
- Check key pair configuration
- Ensure instance is in running state

**Application not responding**
- Check instance status checks
- Review application logs in `/var/log/custom/`
- Verify security group allows required ports

### Support

For technical support, contact: ${{ values.owner }}

## Cost Optimization

- Use appropriate instance types for workload
- Enable detailed monitoring only when needed
- Consider Reserved Instances for long-running workloads
- Set up billing alerts in AWS

## Security Best Practices

- Regularly update security groups
- Use IAM roles instead of access keys
- Enable CloudTrail for audit logging
- Implement backup strategies
- Regular security patches and updates