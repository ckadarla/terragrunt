# main.tf

provider "aws" {
  region = "us-west-2"  # Change to your desired region
}

module "vpc_example_complete" {
  source  = "terraform-aws-modules/vpc/aws//examples/complete"
  version = "5.4.0"
}

# Create EKS cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  subnets         = module.vpc.private_subnets_ids  # Use the correct attribute for subnets
  vpc_id          = module.vpc.vpc_id
  cluster_version = "1.26"
  # You can customize EKS cluster configuration here
}

# Deploy sample application to EKS
resource "helm_release" "example" {
  name       = "my-redis-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "6.0.1"

  values = [
    "${file("values.yaml")}"
  ]

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  set {
    name  = "service.annotations.prometheus\\.io/port"
    value = "9127"
    type  = "string"
  }
}


# Add Prometheus and Grafana to EKS
resource "aws_prometheus_workspace" "example" {
  alias = "example"

  tags = {
    Environment = "production"
  }
}
terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "2.8.0"
    }
  }
}

provider "grafana" {
  # Configuration options
}
