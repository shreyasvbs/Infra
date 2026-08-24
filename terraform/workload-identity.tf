resource "azurerm_user_assigned_identity" "eso" {

  name = local.workload_identity_name

  location = azurerm_resource_group.aks.location

  resource_group_name = azurerm_resource_group.aks.name

  tags = local.common_tags
}