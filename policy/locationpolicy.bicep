targetScope = 'managementGroup'


param targetMG string = 'es-tf-02'
var mgScope = tenantResourceId('Microsoft.Management/managementGroups', targetMG)
param listofallowedLocations array = [
  'westeurope'
  'swedencentral'

]

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2019-09-01' = {
  name: 'location-Restriction-test'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    description: 'This policy enables you to restrict the other locations your organization can specify when deploying resources. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the global region.'
    parameters: {
      allowedLocations: {
        type: 'Array'
      }

    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'location'
            notIn: '[parameters(\'allowedLocations\')]'
          }
          {
            field: 'location'
            notEquals: 'global'
          }
          {
            field: 'type'
            notEquals: 'Microsoft.AzureActiveDirectory/b2cDirectories'
          }
        ]
      }
      
      then: {
        effect: 'deny'
      }
    }
  }
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'locationAssignment'
  properties: {
    scope: mgScope
    policyDefinitionId: extensionResourceId(mgScope, 'Microsoft.Authorization/policyDefinitions', policyDefinition.name)
    displayName: 'Allowed location for Azure resources'
    parameters: {
      allowedLocations: {
        value: listofallowedLocations
      }
    }
  }
}
