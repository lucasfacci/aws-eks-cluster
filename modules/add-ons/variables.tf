variable "project_name" {
  type        = string
  description = "Project name that will be used as the resource name prefix."
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "oidc" {
  type        = string
  description = "HTTPS URL from OIDC provider of the EKS cluster."
}

variable "tags" {
  type        = map(any)
  description = "Tags that will be associated with the created resources."
}
