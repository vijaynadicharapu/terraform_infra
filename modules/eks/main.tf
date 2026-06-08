#################################################
# EKS Cluster
#################################################

resource "aws_eks_cluster" "eks" {

  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn

  version = var.cluster_version

  vpc_config {

    subnet_ids = var.private_subnet_ids

    endpoint_private_access = false
    endpoint_public_access  = true
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

#################################################
# Managed Node Group
#################################################

resource "aws_eks_node_group" "nodegroup" {

  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.cluster_name}-ng"

  node_role_arn = var.eks_node_group_role_arn

  subnet_ids = var.private_subnet_ids

  ami_type = "AL2023_x86_64_STANDARD"

  capacity_type = "ON_DEMAND"

  instance_types = [
    "t3.small"
  ]

  scaling_config {

    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }

  depends_on = [
    aws_eks_cluster.eks
  ]
}

#################################################
# OIDC Provider Data
#################################################

data "tls_certificate" "eks" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

#################################################
# OIDC Provider
#################################################

resource "aws_iam_openid_connect_provider" "eks" {

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.eks.certificates[0].sha1_fingerprint
  ]

  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}