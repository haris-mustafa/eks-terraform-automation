variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "project" {
  type    = string
  default = "eks-automation"
}

variable "environment" {
  description = "dev | prod"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be 'dev' or 'prod'."
  }
}

variable "vpc_cidr" {
  type = string
}

variable "az_count" {
  description = "Number of AZs to use (2-4)."
  type        = number
  default     = 2
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "cluster_version" {
  type = string
}

variable "endpoint_public_access_cidrs" {
  description = "Who may reach the public API endpoint. Restrict this in prod."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_log_types" {
  type    = list(string)
  default = ["api", "audit", "authenticator"]
}

variable "node_groups" {
  type = map(object({
    instance_types = list(string)
    capacity_type  = optional(string, "ON_DEMAND")
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size      = optional(number, 50)
    labels         = optional(map(string), {})
  }))
}
