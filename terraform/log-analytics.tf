resource "azurerm_log_analytics_workspace" "aks" {

  name = local.log_analytics_name

  location = azurerm_resource_group.aks.location

  resource_group_name = azurerm_resource_group.aks.name

  sku = "PerGB2018"

  retention_in_days = 30

  tags = local.common_tags
}