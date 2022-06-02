param location string = resourceGroup().location
param name string

@allowed([
  'Dynamic'
  'Static'
])
param ipAllocationMethod string
param domainNameLabel string

resource name_resource 'Microsoft.Network/publicIPAddresses@2019-09-01' = {
  name: name
  location: location
  properties: {
    publicIPAllocationMethod: ipAllocationMethod
    dnsSettings: {
      domainNameLabel: domainNameLabel
    }
  }
}