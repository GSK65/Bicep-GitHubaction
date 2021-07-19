param location string = 'westeurope'


resource rg01 'Microsoft.Network/virtualNetworks@2021-02-01' = {

  name : 'network001'
  location: location
   properties: {
     subnets: subnet ['10.0.0.1/24']

   }
}
