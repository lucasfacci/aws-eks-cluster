variable "project_name" {
  type        = string
  description = "Project name that will be used as the resource name prefix."
}

variable "vpc" {
  type        = string
  description = "Project VPC."
}

variable "public_subnet_1a" {
  type        = string
  description = "Subnet for Bastion Host."
}

variable "private_subnet_1a" {
  type        = string
  description = "Subnet for MongoDB."
}

variable "cluster_sg" {
  type        = string
  description = "EKS Cluster Security Group."
}

variable "tags" {
  type        = map(any)
  description = "Tags that will be associated with the created resources."
}
