variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public Subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private Subnets"
  type        = list(string)
}

variable "instance_types" {
  description = "EKS Worker Node Types"
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
