provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Change to your desired AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.my_subnet.id

  tags = {
    Name = "MyInstance"
  }
}

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # Change to your desired AZ
  map_public_ip_on_launch = true
}
