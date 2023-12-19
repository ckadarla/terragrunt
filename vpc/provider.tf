terraform {
  required_version = ">= 1.0"

  backend "local" {
    path = "/var/jenkins_home/state/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}