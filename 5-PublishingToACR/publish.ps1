az acr list -o table

$acr=az acr show -n GordoPremiumReg -g Docker-Gen -o json | ConvertFrom-Json

#Upload bicep to ACR on specific version tag
$version="v1"
$targetUri="br:$($acr.loginServer)/bicep/modules/simplevm:$version"
bicep publish 1-AzureVM\azureVm.bicep --target $targetUri

#Upload bicep to ACR using latest tag for evergreen users
$targetUri="br:$($acr.loginServer)/bicep/modules/simplevm:latest"
bicep publish 1-AzureVM\azureVm.bicep --target $targetUri