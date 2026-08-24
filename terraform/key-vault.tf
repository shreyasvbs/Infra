resource "azurerm_key_vault" "aks" {

  name = local.key_vault_name

  location = azurerm_resource_group.aks.location

  resource_group_name = azurerm_resource_group.aks.name

  tenant_id = var.tenant_id

  sku_name = "standard"

  enable_rbac_authorization = true

  purge_protection_enabled = true

  soft_delete_retention_days = 7

  tags = local.common_tags
}