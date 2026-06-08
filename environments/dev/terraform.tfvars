aws_region = "us-east-1"

project_name = "devops-platform"

environment = "dev"

cluster_name = "devops-platform-dev"

vpc_cidr = "10.0.0.0/16"

azs = [
  "us-east-1a",
  "us-east-1b",
]

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24",
]

private_subnets = [
  "10.0.11.0/24",
  "10.0.12.0/24",
]

instance_types = [
  "t3.small",
]

desired_size = 2

min_size = 1

max_size = 2
