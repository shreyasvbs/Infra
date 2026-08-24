output "resource_group_name" {

  value = azurerm_resource_group.aks.name
}


output "aks_cluster_name" {

  value = azurerm_kubernetes_cluster.aks.name
}


output "aks_cluster_id" {

  value = azurerm_kubernetes_cluster.aks.id
}


output "aks_oidc_issuer_url" {

  value = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}


output "eso_identity_client_id" {

  value = azurerm_user_assigned_identity.eso.client_id
}


output "eso_identity_principal_id" {

  value = azurerm_user_assigned_identity.eso.principal_id
}


output "key_vault_name" {

  value = azurerm_key_vault.aks.name
}


output "key_vault_uri" {

  value = azurerm_key_vault.aks.vault_uri
}


output "eso_namespace" {

  value = var.eso_namespace
}


output "eso_service_account" {

  value = var.eso_service_account_name
}