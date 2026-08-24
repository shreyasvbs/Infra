resource "azurerm_kubernetes_cluster" "aks" {

  name = local.aks_name

  location = azurerm_resource_group.aks.location

  resource_group_name = azurerm_resource_group.aks.name

  dns_prefix = local.aks_name

  kubernetes_version = var.kubernetes_version

  sku_tier = "Standard"


  ############################################################
  # SYSTEM IDENTITY
  ############################################################

  identity {
    type = "SystemAssigned"
  }


  ############################################################
  # SYSTEM NODE POOL
  ############################################################

  default_node_pool {

    name = "system"

    vm_size = var.system_node_vm_size

    type = "VirtualMachineScaleSets"

    vnet_subnet_id = azurerm_subnet.aks.id

    auto_scaling_enabled = true

    min_count = var.system_node_min_count

    max_count = var.system_node_max_count

    os_disk_type = "Managed"

    os_disk_size_gb = 128

    max_pods = 50

    zones = [
      "1"
    ]

    node_labels = {
      "nodepool-type" = "system"
    }

    tags = local.common_tags
  }


  ############################################################
  # NETWORKING
  ############################################################

  network_profile {

    network_plugin = "azure"

    network_plugin_mode = "overlay"

    network_policy = "azure"

    load_balancer_sku = "standard"

    outbound_type = "loadBalancer"

    pod_cidr = "10.244.0.0/16"

    service_cidr = "10.0.0.0/16"

    dns_service_ip = "10.0.0.10"
  }


  ############################################################
  # MICROSOFT ENTRA ID
  ############################################################

  azure_active_directory_role_based_access_control {

    tenant_id = var.tenant_id

    azure_rbac_enabled = true

    admin_group_object_ids = var.admin_group_object_ids
  }


  ############################################################
  # OIDC
  ############################################################

  oidc_issuer_enabled = true


  ############################################################
  # WORKLOAD IDENTITY
  ############################################################

  workload_identity_enabled = true


  ############################################################
  # AZURE POLICY
  ############################################################

  azure_policy_enabled = true


  ############################################################
  # MONITORING
  ############################################################

  oms_agent {

    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks.id
  }


  ############################################################
  # KEY VAULT CSI
  ############################################################

  key_vault_secrets_provider {

    secret_rotation_enabled = true

    secret_rotation_interval = "2m"
  }


  ############################################################
  # AUTO UPGRADE
  ############################################################

  automatic_upgrade_channel = "patch"


  ############################################################
  # MAINTENANCE
  ############################################################

  maintenance_window {

    allowed {

      day = "Sunday"

      hours = [
        2,
        3,
        4
      ]
    }
  }


  tags = local.common_tags
}