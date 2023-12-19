# main.tf

provider "aws" {
  region = "us-west-2"  # Change to your desired region
}

# Create VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  # You can customize VPC configuration here
}

# Create EKS cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  cluster_version = "1.20"
  # You can customize EKS cluster configuration here
}

# Deploy sample application to EKS
module "sample_app" {
  source    = "terraform-aws-modules/kubernetes/helm_release"
  chart     = "stable/nginx-ingress"
  namespace = "default"
  name      = "nginx-ingress"
  version   = "1.41.3"
  # You can customize application deployment here
}

# Add Prometheus and Grafana to EKS
module "prometheus" {
  source            = "terraform-aws-modules/prometheus/aws"
  prometheus_name   = "my-prometheus"
  cluster_name      = module.eks.cluster_id
  cluster_arn       = module.eks.cluster_arn
  enable_alertmanager = true
  alertmanager_config = file("${path.module}/alertmanager-config.yaml")
}

module "grafana" {
  source                = "terraform-aws-modules/grafana/aws"
  cluster_name          = module.eks.cluster_id
  cluster_arn           = module.eks.cluster_arn
  namespace             = "grafana"
  additional_iam_policies = ["arn:aws:iam::aws:policy/CloudWatchFullAccess"]
}

