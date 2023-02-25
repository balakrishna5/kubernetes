# kubernetes
this repo is to learn kubernetes



az acr login --name bkazurecontainerrepo1

az acr create --resource-group bkuserkubernetesgroup --name bkazurecontainerrepo1 --sku Basic 


docker tag aksuserapi-image  bkazurecontainerrepo1.azurecr.io/aksuserapi-image

docker push bkazurecontainerrepo1.azurecr.io/aksuserapi-image

az aks create --resource-group bkuserkubernetesgroup --name bkaks --node-count 2 --generate-ssh-keys --attach-acr bkazurecontainerrepo1


az aks get-credentials --resource-group bkuserkubernetesgroup --name bkaks

az group create --name bkresourcegroup --location westeurope

az storage account create --resource-group bkresourcegroup --name bk9storageaccount --sku Standard_LRS --encryption-services blob

az storage container create --name bk9container --account-name bk9storageaccount

