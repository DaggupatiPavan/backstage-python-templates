#!/bin/bash

# User data script for EC2 instance initialization
# This script runs when the instance first boots

# Update system packages
yum update -y

# Install essential packages
yum install -y \
    htop \
    git \
    curl \
    wget \
    unzip \
    vim \
    docker

# Configure instance hostname
hostnamectl set-hostname ${instance_name}

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Add ec2-user to docker group
usermod -a -G docker ec2-user

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Install CloudWatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
rpm -U ./amazon-cloudwatch-agent.rpm

# Create a simple web server for health checks
cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>${instance_name}</title>
</head>
<body>
    <h1>${instance_name}</h1>
    <p>Environment: ${environment}</p>
    <p>Instance is running successfully!</p>
    <p>Timestamp: $(date)</p>
</body>
</html>
EOF

# Install and start Apache
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Set up log rotation
cat << 'EOF' > /etc/logrotate.d/custom-logs
/var/log/custom/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 644 root root
}
EOF

# Create custom log directory
mkdir -p /var/log/custom

# Log the completion of user data script
echo "$(date): User data script completed successfully for ${instance_name}" >> /var/log/custom/user-data.log

# Send completion notification to CloudWatch (optional)
# aws logs create-log-group --log-group-name /aws/ec2/${instance_name} --region $(curl -s http://169.254.169.254/latest/meta-data/placement/region) || true