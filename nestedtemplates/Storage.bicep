param location string = resourceGroup().location

@description('The name for the storage account')
@maxLength(25)
param storageAccountName string

@description('The sku for the storage account')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Premium_LRS'
])
param storageSku string = 'Standard_LRS'

resource storageAccountName_resource 'Microsoft.Storage/storageAccounts@2019-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSku
  }
  kind: 'Storage'
  properties: {}
}