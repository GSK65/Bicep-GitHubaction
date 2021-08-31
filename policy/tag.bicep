targetScope = 'subscription'
var policyName_var = 'enforce-resource-group-tags-pd'
var policyDisplayName = 'Enforce using specific tags when deploying resource groups'
var policyDescription = 'This policy enforces mandatory tags to use when deploying resource groups'

resource policyName 'Microsoft.Authorization/policyDefinitions@2019-09-01' = {
  name: policyName_var
  properties: {
    displayName: policyDisplayName
    policyType: 'Custom'
    description: policyDescription
    metadata: {
      category: 'Tags'
    }
    parameters: {
      allowedEnvironmentTagValues: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed \'environment\' tag values'
          description: 'The list of allowed values for \'Environment\' tag.'
        }
      }
      allowedCriticalityTagValues: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed \'criticality\' tag values'
          description: 'The list of allowed values for \'Criticality\' tag.'
        }
      }
    }
    mode: 'Indexed'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Resources/subscriptions/resourceGroups'
          }
          {
            field: 'tags[\'applicationName\']'
            exists: 'false'
          }
          {
            field: 'tags[\'environment\']'
            in: '[parameters(\'allowedEnvironmentTagValues\')]'
          }
          {
            field: 'tags[\'owner\']'
            like: '*@yourdomain.com'
          }
          {
            field: 'tags[\'criticality\']'
            in: '[parameters(\'allowedCriticalityTagValues\')]'
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}