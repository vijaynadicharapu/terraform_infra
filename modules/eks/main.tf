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
# EKS Managed Addons
#################################################

resource "aws_eks_addon" "coredns" {

cluster_name = aws_eks_cluster.eks.name

addon_name = "coredns"

depends_on = [
aws_eks_cluster.eks
]
}

resource "aws_eks_addon" "kube_proxy" {

cluster_name = aws_eks_cluster.eks.name

addon_name = "kube-proxy"

depends_on = [
aws_eks_cluster.eks
]
}

resource "aws_eks_addon" "vpc_cni" {

cluster_name = aws_eks_cluster.eks.name

addon_name = "vpc-cni"

depends_on = [
aws_eks_cluster.eks
]
}

resource "aws_eks_addon" "ebs_csi_driver" {

cluster_name = aws_eks_cluster.eks.name

addon_name = "aws-ebs-csi-driver"

depends_on = [
aws_eks_cluster.eks
]
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

  instance_types = var.instance_types

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
    aws_eks_cluster.eks,
    aws_eks_addon.coredns,
    aws_eks_addon.kube_proxy,
    aws_eks_addon.vpc_cni,
    aws_eks_addon.ebs_csi_driver
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