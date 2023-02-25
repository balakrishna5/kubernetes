resource "azurerm_resource_group" "bk_kube_rg" {
  name     = "bk_kube_rg"
  location = "West Europe"
}

resource "azurerm_container_registry" "bk_acr_aks" {
  name                = "bkacr1732"
  resource_group_name = azurerm_resource_group.bk_kube_rg.name
  location            = azurerm_resource_group.bk_kube_rg.location
  sku                 = "Basic"
}

resource "azurerm_kubernetes_cluster" "bk_aks" {
  name                = "bkaks"
  location            = azurerm_resource_group.bk_kube_rg.location
  resource_group_name = azurerm_resource_group.bk_kube_rg.name
  dns_prefix          = "bkaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
#  this resource is for attaching acr to aks
resource "azurerm_role_assignment" "acr_aks_rbac1" {
  principal_id                     = azurerm_kubernetes_cluster.bk_aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.bk_acr_aks.id
  skip_service_principal_aad_check = true
}