output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "Testing autocomplete"
  value = module.vpc.vpc_cidr_block
  
}