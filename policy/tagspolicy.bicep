targetScope = 'managementGroup'
param targetMG string = 'es-tf-02'
var mgScope = tenantResourceId('Microsoft.Management/managementGroups', targetMG)
var policyName = 'Require Tag'
var policyDisplayName = 'Require a tag on resources - test01'
param owner string = 'owner'

resource policy 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    policyType: 'Custom'
    mode: 'Indexed'
    metadata:  {
     category: 'Tags'
    }
    parameters: {
      tagName: {
        type: 'String'
        metadata: {
          displayName: 'Mandatory Tag'
          description: 'Owner of the tag'
        }
        defaultValue: owner
      }

    }
    
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Resources/subscriptions/resourceGroups'
          }
          {
            field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]'
            exists: 'false'
          }

        ]
      }

      then: {
        effect: 'deny'
      }
    }
  }
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'Tag policy assignment'
  properties: {
    displayName: 'Require the Tag - test01'
    policyDefinitionId: extensionResourceId(mgScope, 'Microsoft.Authorization/policyDefinitions', policy.name)
  }
}
