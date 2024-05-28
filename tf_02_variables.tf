variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region where the resources will be allocated."
}

variable "project_name" {
  type        = string
  description = "Project name that will be used as the resource name prefix."
}

variable "cidr_block" {
  type        = string
  description = "Networking CIDR block that will be used in the VPC."
}

variable "github_account_and_repository" {
  description = "The GitHub repository name."
  type        = string
}

variable "github_repository_branch_name" {
  description = "The GitHub branch name."
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags that will be associated with all the resources."
}
