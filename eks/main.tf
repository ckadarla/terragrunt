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

# alertmanager-config.yaml

route:
  group_wait: 10s
  group_interval: 5m
  repeat_interval: 3h

receivers:
  - name: "default-receiver"
    slack_configs:
      - channel: "#alerts"
        send_resolved: true

# Add Prometheus alerts (customize based on your application metrics)
# Example alert rule for high CPU usage
resource "prometheus_alert" "high_cpu_alert" {
  provider         = module.prometheus.provider
  rule             = file("${path.module}/prometheus-alerts/high-cpu-alert.yaml")
  group_wait       = "10s"
  group_interval   = "5m"
  repeat_interval  = "3h"
}

# high-cpu-alert.yaml

groups:
- name: HighCPULoad
  rules:
  - alert: HighCPULoad
    expr: sum(rate(container_cpu_usage_seconds_total{container!="POD",namespace="default"}[5m])) > 0.8
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "High CPU usage detected"
      description: "Container {{ $labels.container }} in namespace {{ $labels.namespace }} is using high CPU."
