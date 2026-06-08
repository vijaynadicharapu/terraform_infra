################################################
# VPC
################################################

module "vpc" {

  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  cluster_name = var.cluster_name

  vpc_cidr = "10.0.0.0/16"

  azs = [
    "us-east-1a",
    "us-east-1b"
  ]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

################################################
# IAM
################################################

module "iam" {

  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

################################################
# ECR
################################################

module "ecr" {

  source = "../../modules/ecr"

  project_name    = var.project_name
  environment     = var.environment
  repository_name = "ecommerce"
}

################################################
# EKS
################################################

module "eks" {

  source = "../../modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_name = var.cluster_name

  private_subnet_ids = module.vpc.private_subnet_ids

  eks_cluster_role_arn    = module.iam.eks_cluster_role_arn
  eks_node_group_role_arn = module.iam.eks_node_group_role_arn

  instance_types = var.instance_types

  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size
}
