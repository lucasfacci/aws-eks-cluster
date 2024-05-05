variable "project_name" {
  type        = string
  description = "Project name that will be used as the resource name prefix."
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "private_subnet_1a" {
  type        = string
  description = "Private subnet AZ 1a to host the EKS cluster worker nodes."
}

variable "private_subnet_1b" {
  type        = string
  description = "Private subnet AZ 1b to host the EKS cluster worker nodes."
}

variable "tags" {
  type        = map(any)
  description = "Tags that will be associated with the created resources."
}
