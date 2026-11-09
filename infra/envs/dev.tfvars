environment        = "dev"
region             = "ap-south-1"
vpc_cidr           = "10.10.0.0/16"
az_count           = 2
single_nat_gateway = true # one NAT keeps dev cheap
cluster_version    = "1.34"

node_groups = {
  general = {
    instance_types = ["t3.small"]
    min_size       = 1
    max_size       = 3
    desired_size   = 2
  }
}
