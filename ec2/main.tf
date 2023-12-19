# provider "aws" {
#   region = "us-east-1"  # Change to your desired AWS region
# }

module "vpc" {
  source = "./../vpc"  # Adjust the path based on your actual directory structure
}

resource "aws_instance" "my_instance" {
  ami           = "ami-09499f802f26db67e"  # Change to your desired AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = [module.vpc.my_sg.id]
  subnet_id              = module.vpc.my_subnet.id

  tags = {
    Name = "MyInstance"
  }
}
