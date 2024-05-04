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

variable "tags" {
  type        = map(string)
  description = "Tags that will be associated with all the resources."
}
