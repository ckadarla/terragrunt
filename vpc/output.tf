output "my_vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "my_sg_id" {
  value = aws_security_group.my_sg.id
}

output "my_subnet_id" {
  value = aws_subnet.my_subnet.id
}
