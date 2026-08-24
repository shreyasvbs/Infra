resource "azurerm_kubernetes_cluster_node_pool" "user" {

  name = "user"

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id

  vm_size = var.user_node_vm_size

  mode = "User"

  type = "VirtualMachineScaleSets"

  vnet_subnet_id = azurerm_subnet.aks.id

  enable_auto_scaling = true

  min_count = var.user_node_min_count

  max_count = var.user_node_max_count

  os_disk_type = "Managed"

  os_disk_size_gb = 128

  max_pods = 50

  zones = [
    "1",
    "2",
    "3"
  ]

  node_labels = {
    "nodepool-type" = "user"
  }

  tags = local.common_tags
}