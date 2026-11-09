environment        = "prod"
region             = "ap-south-1"
vpc_cidr           = "10.20.0.0/16"
az_count           = 3
single_nat_gateway = false # one NAT per AZ for high availability
cluster_version    = "1.34"

# Restrict the public API endpoint to your office / VPN CIDR(s) in a real prod setup.
endpoint_public_access_cidrs = ["0.0.0.0/0"]
cluster_log_types            = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

node_groups = {
  general = {
    instance_types = ["m5.large"]
    min_size       = 3
    max_size       = 6
    desired_size   = 3
    labels         = { workload = "general" }
  }
}
