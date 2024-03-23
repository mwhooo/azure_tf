module "global_vars" {
   source = "../modules/global"
}

data "azurerm_resource_group" "rg" {
    name = module.global_vars.rg_name
}

data "azurerm_subnet" "windows_subnet" {
    name = module.global_vars.windows_subnet
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name = module.global_vars.vnet_name
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "demo_vault" {
  name = module.global_vars.kv_name
  location = data.azurerm_resource_group.rg.location
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = module.global_vars.kv_sku
  resource_group_name = data.azurerm_resource_group.rg.name
  public_network_access_enabled = false
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get","List"
    ]

    secret_permissions = [
      "Get","List"
    ]
    
    certificate_permissions = [
      "Get","List"
    ]
  }
}

resource "azurerm_private_endpoint" "vault_private_endpoint" {
  name                = "${azurerm_key_vault.demo_vault.name}-ple"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = data.azurerm_subnet.windows_subnet.id

  private_service_connection {
    name                           = "${azurerm_key_vault.demo_vault.name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.demo_vault.id
    subresource_names              = ["vault"]
  }
  depends_on = [ azurerm_key_vault.demo_vault ]
}
