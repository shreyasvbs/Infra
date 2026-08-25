resource "azurerm_key_vault" "aks" {

  name = local.key_vault_name

  location = azurerm_resource_group.aks.location

  resource_group_name = azurerm_resource_group.aks.name

  tenant_id = var.tenant_id

  sku_name = "standard"

  rbac_authorization_enabled = true

  purge_protection_enabled = true

  soft_delete_retention_days = 7

  tags = local.common_tags
}


resource "azurerm_key_vault_secret" "secrets" {

  for_each = var.key_vault_secret_names

  name = each.key

  value = each.value

  key_vault_id = azurerm_key_vault.aks.id

  depends_on = [
    azurerm_role_assignment.eso_keyvault
  ]
}