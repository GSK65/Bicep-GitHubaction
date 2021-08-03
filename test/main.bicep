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
  