resource "azurerm_container_group" "example" {
  name                = var.container_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"

  container {
    name   = var.container_name
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"  // Updated image for testing
    cpu    = var.container_cpu
    memory = var.container_memory

    ports {
      port     = 80
      protocol = "TCP"
    }

    liveness_probe {
      http_get {
        path = "/"
        port = 80
      }
      initial_delay_seconds = 3
      period_seconds        = 3
    }

    readiness_probe {
      http_get {
        path = "/"
        port = 80
      }
      initial_delay_seconds = 3
      period_seconds        = 3
    }
  }

  tags = {
    environment = var.environment
  }
}

output "container_group_ip" {
  value = azurerm_container_group.example.ip_address
}
