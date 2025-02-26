variable "location" {
  description = "The location of the resources"
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "devops-rg"
}

variable "container_group_ip" {
  description = "The IP address of the container group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}
