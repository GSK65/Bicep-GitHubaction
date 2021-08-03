targetScope = 'subscription'

param rgname string
param rglocation string = 'westeurope'

resource rg002 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgname
  location: rglocation
   tags: {
     team : 'dev'
   }
}


module net01 'network01.bicep'= {
  scope: rg002
  name: 'vnetname'
  params: {
    vnetlocation: rglocation
    vnetname: '${rgname}-vnet102'
    
  }
  
}
