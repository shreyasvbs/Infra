subscription_id = "b991bfa1-dccc-498c-a589-d54aecc34646"

tenant_id = "be2f3b76-dbac-415c-89c5-cc4d8b78db15"

location = "Central India"

environment = "dev"

project_name = "platform"


system_node_vm_size = "Standard_D4s_v5"

user_node_vm_size = "Standard_D4s_v5"


system_node_min_count = 2

system_node_max_count = 3

user_node_min_count = 2

user_node_max_count = 5


admin_group_object_ids = [
  "e0d2ca2b-f6ce-4046-bd30-beb103d0beb8"
]


eso_namespace = "external-secrets"

eso_service_account_name = "eso-azure-workload-identity"


tags = {

  Environment = "dev"

  Project = "platform"

  ManagedBy = "Terraform"

  Owner = "DevOps"
}