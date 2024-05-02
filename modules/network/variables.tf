variable "project_name" {
  type        = string
  description = "Project name that will be used as the resource name prefix."
}

variable "cidr_block" {
  type        = string
  description = "Networking CIDR block that will be used in the VPC."
}

variable "tags" {
  type        = map(any)
  description = "Tags that will be associated with the created resources."
}