variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  description = "OIDC issuer without https://"
  type        = string
}

variable "addon_versions" {
  description = "Optional pinned versions per managed add-on. null = EKS default for the cluster version."
  type = object({
    vpc_cni    = optional(string)
    coredns    = optional(string)
    kube_proxy = optional(string)
  })
  default = {}
}

variable "lb_controller_chart_version" {
  description = "aws-load-balancer-controller Helm chart version (1.8.2 ships controller v2.8.2, matching the bundled IAM policy)."
  type        = string
  default     = "1.8.2"
}
