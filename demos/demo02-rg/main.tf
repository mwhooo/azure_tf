resource "azurerm_resource_group" "rg" {
  location   = var.rg_location
  name       = var.rg_name
  tags       = var.rg_tags
  managed_by = var.managed_by
}


























# module "global_vars" {
#    source = "../modules/global/${var.env}"
# }