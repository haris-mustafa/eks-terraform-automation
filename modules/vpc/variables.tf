variable "name" {
  description = "Name prefix for all VPC resources."
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name, used for the kubernetes.io/cluster subnet tag."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC (a /16 is recommended)."
  type        = string
}

variable "azs" {
  description = "Availability zones to spread subnets across."
  type        = list(string)

  validation {
    condition     = length(var.azs) >= 2 && length(var.azs) <= 4
    error_message = "EKS needs subnets in at least 2 AZs; this module supports up to 4."
  }
}

variable "single_nat_gateway" {
  description = "true = one shared NAT (cheap, dev). false = one NAT per AZ (HA, prod)."
  type        = bool
  default     = true
}
