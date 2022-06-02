param location string = resourceGroup().location

@description('The name for the virtual network')
param vnetName string

@description('The address space for the virtual network')
param addressPrefix string = '10.0.0.0/16'

@description('The name for the subnet')
param subnetName string = 'Default'

@description('The address space for the subnet')
param subnetPrefix string = '10.0.0.0/24'

resource vnetName_resource 'Microsoft.Network/virtualNetworks@2019-09-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}