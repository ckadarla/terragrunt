
terraform {
  backend "local" {
    path = "/var/jenkins_home/state/ec2/terraform.tfstate"
  }
}
