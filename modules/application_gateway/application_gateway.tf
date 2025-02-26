// Application Gateway Resource
resource "azurerm_application_gateway" "example" {
  name                = "devops-appgateway"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontendport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontendipconfiguration"
    public_ip_address_id = azurerm_public_ip.example.id
  }

  backend_address_pool {
    name = "backendpool"
    ip_addresses = [var.container_group_ip]
  }

  backend_http_settings {
    name                  = "backendhttsettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "httplistener"
    frontend_ip_configuration_name = "frontendipconfiguration"
    frontend_port_name             = "frontendport"
    protocol                       = "Http"
  }

  url_path_map {
    name = "urlpathmap"
    default_backend_address_pool_name = "backendpool"
    default_backend_http_settings_name = "backendhttsettings"

    path_rule {
      name                       = "pathrule1"
      paths                      = ["/path1/*"]
      backend_address_pool_name  = "backendpool"
      backend_http_settings_name = "backendhttsettings"
    }
  }

  request_routing_rule {
    name                       = "rulename"
    rule_type                  = "Basic"
    http_listener_name         = "httplistener"
    backend_address_pool_name  = "backendpool"
    backend_http_settings_name = "backendhttsettings"
    priority                   = 100
  }

  tags = {
    environment = "testing"
    project     = "devops"
    owner       = "locta"
  }
}

// Public IP Resource
resource "azurerm_public_ip" "example" {
  name                = "devops-publicip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}