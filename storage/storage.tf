provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = "loctadevopsteststorage"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on = [azurerm_resource_group.example]
}

resource "azurerm_storage_container" "example" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.example.id
  container_access_type = "private"
  depends_on = [azurerm_storage_account.example]
}