param myAppName string = 'Gordons cool app'

@description('Using a module stored in an Azure Container Registry')
module vm1 'br:gordopremiumreg.azurecr.io/bicep/modules/simplevm:v1' = {
  name: 'vm1'
  params: {
    vmAdminPassword: 'asdfasd343msadfskSDFS44$$'
    vmName: 'gordvm1'
  }
}
