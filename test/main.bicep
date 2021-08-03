targetScope = 'subscription'

param rgname string
param location string

resource rg001 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgname
  location: location
  tags: {
    Team : 'Test001'
    env : 'dev'
  } 
}  

param vnetname string

module nw01 'network01.bicep'= {
  scope: rg001
  name: vnetname
  params: {
    vnetname: vnetname
    
  }

  }
  
