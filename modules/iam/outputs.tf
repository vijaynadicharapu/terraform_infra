output "eks_cluster_role_arn" {

  description = "EKS Cluster Role ARN"

  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_cluster_role_name" {

  description = "EKS Cluster Role Name"

  value = aws_iam_role.eks_cluster_role.name
}

output "eks_node_group_role_arn" {

  description = "Node Group Role ARN"

  value = aws_iam_role.eks_node_group_role.arn
}

output "eks_node_group_role_name" {

  description = "Node Group Role Name"

  value = aws_iam_role.eks_node_group_role.name
}