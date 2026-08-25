provider "azurerm" {
  features {}

  resource_provider_registrations = "none"

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}


data "azurerm_client_config" "current" {}


provider "kubernetes" {

  host = azurerm_kubernetes_cluster.aks.kube_config[0].host

  cluster_ca_certificate = base64decode(
    azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  )

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args        = ["get-token", "--login", "azurecli"]
  }
}


provider "helm" {

  kubernetes {

    host = azurerm_kubernetes_cluster.aks.kube_config[0].host

    cluster_ca_certificate = base64decode(
      azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
    )

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "kubelogin"
      args        = ["get-token", "--login", "azurecli"]
    }
  }
}