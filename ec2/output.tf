output "my_vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "ec2_instance_id" {
  value = aws_instance.my_instance.id
  
  
}

output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}
