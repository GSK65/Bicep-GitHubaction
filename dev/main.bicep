targetScope = 'subscription'

param rgname string = 'RG003'
param rglocation string = 'westeurope'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgname
  location: rglocation
   tags: {
     team : 'dev'
   }
}


module net01 'network01.bicep'= {
  scope: rg
  name: 'vnetname'
  params: {
    vnetlocation: rglocation
    vnetname: '${rgname}-vnet102'
    
  }
  
}

@batchSize(2)
resource resourceGroups 'Microsoft.Resources/resourceGroups@2020-06-01' = [for i in range(0,10): {
  name: 'RG00-${i}'
  location: 'westeurope'
}]
