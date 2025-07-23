output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.main.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.main.private_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.main.public_dns
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.instance_sg.id
}

# output "elastic_ip" {
#   description = "Elastic IP address"
#   value       = aws_eip.main.public_ip
# }

output "ssh_connection_command" {
  description = "SSH connection command"
  {% if values.key_name %}
  value = "ssh -i ~/.ssh/${{ values.key_name }}.pem ec2-user@${aws_instance.main.public_ip}"
  {% else %}
  value = "SSH key not configured. Please set up key pair for SSH access."
  {% endif %}
}