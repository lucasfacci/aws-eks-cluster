variable "project_name" {
  type        = string
  description = "Project name that will be used as the resource name prefix."
}

variable "public_subnet_1a" {
  type        = string
  description = "Public subnet AZ 1a to host the EKS cluster."
}

variable "public_subnet_1b" {
  type        = string
  description = "Public subnet AZ 1b to host the EKS cluster."
}

variable "tags" {
  type        = map(any)
  description = "Tags that will be associated with the created resources."
}

variable "github_account_and_repository" {
  description = "The GitHub repository name."
  type        = string
}

variable "github_repository_branch_name" {
  description = "The GitHub branch name."
  type        = string
}
