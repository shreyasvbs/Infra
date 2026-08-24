resource "helm_release" "external_secrets" {

  name = "external-secrets"

  repository = "https://charts.external-secrets.io"

  chart = "external-secrets"

  version = var.eso_helm_chart_version

  namespace = var.eso_namespace

  create_namespace = true

  wait = true

  timeout = 600

  atomic = true

  values = [

    yamlencode({

      installCRDs = true

      serviceAccount = {

        create = true

        name = var.eso_service_account_name

        annotations = {

          "azure.workload.identity/client-id" = azurerm_user_assigned_identity.eso.client_id

          "azure.workload.identity/tenant-id" = var.tenant_id
        }
      }

      podLabels = {

        "azure.workload.identity/use" = "true"
      }

    })
  ]

  depends_on = [

    azurerm_kubernetes_cluster.aks,

    azurerm_federated_identity_credential.eso,

    azurerm_role_assignment.eso_keyvault
  ]
}