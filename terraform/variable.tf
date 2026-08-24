variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Central India"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aks-platform"
}


variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
  default     = null
}


variable "vnet_address_space" {
  description = "VNet CIDR"
  type        = list(string)

  default = [
    "10.10.0.0/16"
  ]
}


variable "aks_subnet_address_prefixes" {
  description = "AKS subnet CIDR"
  type        = list(string)

  default = [
    "10.10.0.0/20"
  ]
}


variable "system_node_vm_size" {
  description = "System node VM size"
  type        = string
  default     = "Standard_D4s_v5"
}


variable "user_node_vm_size" {
  description = "User node VM size"
  type        = string
  default     = "Standard_D4s_v5"
}


variable "system_node_min_count" {
  type    = number
  default = 2
}


variable "system_node_max_count" {
  type    = number
  default = 3
}


variable "user_node_min_count" {
  type    = number
  default = 2
}


variable "user_node_max_count" {
  type    = number
  default = 5
}


variable "admin_group_object_ids" {
  description = "Microsoft Entra ID group object IDs"
  type        = list(string)

  default = []
}


variable "eso_namespace" {
  description = "External Secrets namespace"
  type        = string
  default     = "external-secrets"
}


variable "eso_service_account_name" {
  description = "Service account used by ESO SecretStores"
  type        = string
  default     = "eso-azure-workload-identity"
}


variable "eso_helm_chart_version" {
  description = "External Secrets Operator Helm chart version"
  type        = string

  # Pin this to the version you validate in your environment.
  default = "0.20.2"
}


variable "key_vault_secret_names" {
  description = "Secrets to create in Azure Key Vault"
  type        = map(string)

  default = {
    database-password = "change-me"
    api-key           = "change-me"
  }
}


variable "tags" {
  type = map(string)

  default = {
    ManagedBy = "Terraform"
    Project   = "AKS"
  }
}