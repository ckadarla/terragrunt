# output "my_vpc_id" {
#   value = module.vpc.aws_vpc.my_vpc
# }

output "ec2_instance_id" {
  value = aws_instance.my_instance.id
  
  
}

output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}


output "my_vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "my_sg_id" {
  value = aws_security_group.my_sg.id
}

output "my_subnet_id" {
  value = aws_subnet.my_subnet.id
}
