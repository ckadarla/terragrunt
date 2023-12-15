terraform {
  source = "/vpc/module/dev///"
}

inputs = {
  ami             = "ami-09499f802f26db67e"
  instance_type   = "t2.micro"
  
}
