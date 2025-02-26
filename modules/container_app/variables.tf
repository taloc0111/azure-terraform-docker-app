variable "container_group_name" {
  description = "The name of the container group"
  default     = "devops-containergroup"
}

variable "container_name" {
  description = "The name of the container"
  default     = "devops-container"
}

variable "container_image" {
  description = "The image of the container"
  default     = "nginx:latest"
}

variable "container_cpu" {
  description = "The CPU allocated to the container"
  default     = "0.5"
}

variable "container_memory" {
  description = "The memory allocated to the container"
  default     = "1.5"
}

variable "environment" {
  description = "The environment tag"
  default     = "testing"
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
