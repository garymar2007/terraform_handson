output "instance_id" {
  description = "The instance id"
  value       = aws_instance.my_test_ec2.id
}

output "instance_public_ip" {
  description = "The public IP address"
  value       = aws_eip.my_test-eip.public_ip
}

output "instance_private_ip" {
  description = "The private IP address"
  value       = aws_instance.my_test_ec2.private_ip
}

output "instance_availability_zone" {
  description = "The availability zone of the instance"
  value       = aws_instance.my_test_ec2.availability_zone
}