resource peer 'microsoft.network/virtualNetworks/virtualNetworkPeerings@2020-05-01'  = {
  name: 'vnet001/peering-to-vnet002'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId('Bicep-RG001', 'Microsoft.Network/virtualNetworks', 'vnet002')
    }
  }
}
