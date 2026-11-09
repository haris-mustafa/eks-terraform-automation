output "lb_controller_role_arn" {
  value = aws_iam_role.lb_controller.arn
}

output "installed_addons" {
  value = [
    aws_eks_addon.vpc_cni.addon_name,
    aws_eks_addon.coredns.addon_name,
    aws_eks_addon.kube_proxy.addon_name,
    helm_release.lb_controller.name,
  ]
}
