provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  resource_provider_registrations = "none"

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}


data "azurerm_client_config" "current" {}


provider "kubernetes" {

  host = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host

  cluster_ca_certificate = base64decode(
    azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate
  )

  client_certificate = base64decode(
    azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate
  )

  client_key = base64decode(
    azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key
  )
}


provider "helm" {

  kubernetes {

    host = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host

    cluster_ca_certificate = base64decode(
      azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate
    )

    client_certificate = base64decode(
      azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate
    )

    client_key = base64decode(
      azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key
    )
  }
}