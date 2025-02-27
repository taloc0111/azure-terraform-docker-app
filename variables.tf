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
  default     = "5235e835-1234-4321-bef0-e1f911233cbb"  // Replace with your subscription ID
  type        = string
}

variable "resource_storage_account" {
  description = "The name of the storage account"
  default     = "loctadevopsteststorage"
}

variable "resource_storage_container" {
  description = "The name of the storage container"
  default     = "tfstate"
}
// Removed subnet_id variable as it is now referenced directly
