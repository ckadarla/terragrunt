
terraform {
  backend "local" {
    path = "/var/jenkins_home/state/vpc/terraform.tfstate"
  }
}
