resource "azurerm_private_dns_zone" "example" {
  name                = "privatedevops.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_a_record" "example" {
  name                = "test"
  zone_name           = azurerm_private_dns_zone.example.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [var.container_group_ip]
}
