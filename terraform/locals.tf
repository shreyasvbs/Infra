locals {

  name_prefix = "${var.project_name}-${var.environment}"


  resource_group_name = "${local.name_prefix}-rg"

  aks_name = "${local.name_prefix}-aks"

  vnet_name = "${local.name_prefix}-vnet"

  aks_subnet_name = "${local.name_prefix}-aks-subnet"


  log_analytics_name = "${local.name_prefix}-law"


  key_vault_name = substr(
    replace(
      "${local.name_prefix}-${substr(var.subscription_id, 0, 8)}-kv",
      "-",
      ""
    ),
    0,
    24
  )


  workload_identity_name = "${local.name_prefix}-eso-identity"


  federated_identity_name = "${local.name_prefix}-eso-federated"


  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}