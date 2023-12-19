# output "vpc_id" {
#   value = module.vpc.my_vpc.id
# }

output "ec2_instance_id" {
  value = aws_instance.my_instance.id
  value = module.vpc.vpc_id
  
}

output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}
