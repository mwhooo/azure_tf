
resource "azurerm_resource_group" "rg" {
  location   = var.rg_location
  name       = var.rg_name
  tags       = var.tags
  managed_by = var.managed_by
}
