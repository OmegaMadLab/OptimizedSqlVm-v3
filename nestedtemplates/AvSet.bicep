param avSetName string
param location string = resourceGroup().location
param faultDomainCount int = 2
param updateDomainCount int = 5

@description('The ID of the Proximity Placement Group')
param ppgId string = ''

resource avSetName_resource 'Microsoft.Compute/availabilitySets@2019-07-01' = {
  name: avSetName
  location: location
  properties: {
    platformFaultDomainCount: faultDomainCount
    platformUpdateDomainCount: updateDomainCount
    proximityPlacementGroup: ((ppgId == '') ? json('null') : json('{"id": "${ppgId}"}'))
  }
  sku: {
    name: 'aligned'
  }
}