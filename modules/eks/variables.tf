variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes Version"
  type        = string
  default     = "1.32"
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "eks_cluster_role_arn" {
  description = "EKS Cluster Role ARN"
  type        = string
}

variable "eks_node_group_role_arn" {
  description = "EKS Node Group Role ARN"
  type        = string
}

variable "instance_types" {
  description = "Worker Node Instance Types"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired Node Count"
  type        = number
}

variable "min_size" {
  description = "Minimum Node Count"
  type        = number
}

variable "max_size" {
  description = "Maximum Node Count"
  type        = number
}
