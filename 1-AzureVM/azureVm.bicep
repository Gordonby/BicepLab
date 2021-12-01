@minLength(1)
param vmName string

@secure()
param vmAdminPassword string

@allowed([
  '2008-R2-SP1'
  '2012-Datacenter'
  '2012-R2-Datacenter'
  '2016-Datacenter'
])
param vmWindowsOSVersion string = '2016-Datacenter'

@allowed([
  'Small'
  'Large'
])
param VmSize string = 'Small'

param location string = resourceGroup().location

param vmAdminUserName string = 'adminsnow'

var vmVmSize = ((VmSize == 'Small') ? 'Standard_A0' : 'Standard_DS3_v2')
param virtualNetworkName string = 'SnowLabVNet'
param virtualNetworkResourceGroup string = 'SnowLab'
var vmVnetID = resourceId(virtualNetworkResourceGroup, 'Microsoft.Network/virtualNetworks', virtualNetworkName)
var vmSubnetRef = '${vmVnetID}/subnets/Windows-Sandbox'

//NIC
var vmNicName_var = '${vmName}NetworkInterface'

resource vmNicName 'Microsoft.Network/networkInterfaces@2021-03-01' = {
  name: vmNicName_var
  location: location
  tags: {
    displayName: 'vmNic'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: vmSubnetRef
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2016-04-30-preview' = {
  name: vmName
  location: location
  tags: {
    displayName: 'vm'
  }
  properties: {
    hardwareProfile: {
      vmSize: vmVmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: vmAdminUserName
      adminPassword: vmAdminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: vmWindowsOSVersion
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vmNicName.id
        }
      ]
    }
  }
}
