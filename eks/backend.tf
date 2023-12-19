
terraform {
  backend "local" {
    path = "/var/jenkins_home/state/eks/terraform.tfstate"
  }
}
