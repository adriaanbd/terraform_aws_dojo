output "vpc_id" {
    description = "The ID of the Main VPC"
    values      = module.network.vpc_id
}