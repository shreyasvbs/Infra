resource "azurerm_user_assigned_identity" "eso" {

  name = local.workload_identity_name

  location = azurerm_resource_group.aks.location

  resource_group_name = azurerm_resource_group.aks.name

  tags = local.common_tags
}


resource "azurerm_federated_identity_credential" "eso" {

  name = local.federated_identity_name

  resource_group_name = azurerm_resource_group.aks.name

  parent_id = azurerm_user_assigned_identity.eso.id

  audience = [
    "api://AzureADTokenExchange"
  ]

  issuer = azurerm_kubernetes_cluster.aks.oidc_issuer_url

  subject = "system:serviceaccount:${var.eso_namespace}:${var.eso_service_account_name}"
}


resource "azurerm_role_assignment" "eso_keyvault" {

  scope = azurerm_key_vault.aks.id

  role_definition_name = "Key Vault Secrets User"

  principal_id = azurerm_user_assigned_identity.eso.principal_id
}