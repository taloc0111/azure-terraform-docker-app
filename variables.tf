variable "location" {
  description = "The location of the resources"
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "devops-rg"
}

variable "subscription_id" {
  description = "The subscription ID for the Azure account"
  default     = "5235e835-1234-5678-9123-e1f911233cbb"  // Replace with your subscription ID
  type        = string
}

// Removed subnet_id variable as it is now referenced directly
