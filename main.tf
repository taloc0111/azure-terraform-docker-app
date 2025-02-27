provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

terraform {
  backend "azurerm" {
    resource_group_name   = "devops-rg"
    storage_account_name  = "loctadevopsteststorage"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

data "azurerm_resource_group" "existing" {
  name     = var.resource_group_name
  provider = azurerm
}

resource "azurerm_resource_group" "example" {
  count    = data.azurerm_resource_group.existing.id == "" ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = "devops-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

module "container_app" {
  source = "./modules/container_app"
  location = var.location
  resource_group_name = var.resource_group_name
}

module "private_dns_zone" {
  source = "./modules/private_dns_zone"
  resource_group_name = var.resource_group_name
  container_group_ip = module.container_app.container_group_ip
  depends_on = [module.container_app]
}

module "application_gateway" {
  source = "./modules/application_gateway"
  subnet_id = azurerm_subnet.example.id
  container_group_ip = module.container_app.container_group_ip
  depends_on = [module.container_app, module.private_dns_zone]
}